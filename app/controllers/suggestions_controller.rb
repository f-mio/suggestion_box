class SuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_url
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :set_relations, only: [:index, :edit, :show]
  before_action :validate_suggestion_state, only: [:edit, :update, :destroy]


  def index
    @suggestions = Suggestion.all.order(created_at: "DESC")

    # エクセルシートのエクスポート機能
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="suggestion一覧.xlsx"'
      }
    end
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.valid?
      @suggestion.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @suggestion.update(suggestion_params)
      redirect_to suggestion_path(@suggestion.id)
    else
      render :edit
    end
  end

  def destroy
    @suggestion.destroy
    redirect_to root_path
  end

  def search
    condition, filter_hash = set_condition
    @suggestions = Suggestion.where(condition, filter_hash).order(created_at: "DESC")

  end


  private

  def set_url
    @url = request.fullpath
  end

  def set_relations
    @relations = UserDepartmentsRelation.where("user_id = #{current_user.id} AND is_manager = True")
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def validate_suggestion_state
    unless user_signed_in? && current_user.id==@suggestion.user_id && @suggestion.writable
      redirect_to root_path
    end
  end

  def suggestion_params
    sql = "SELECT * FROM user_departments_relations WHERE user_id = #{current_user.id} ORDER BY department_id;"
    relation = UserDepartmentsRelation.find_by_sql(sql).first
    return params.require(:suggestion).permit(
        :title, :issue, :ideal, :category_id,
        :location_id, :place_id, :target,
        :effect, before_images: [], after_images: []
      ).merge(
        user_id: current_user.id,
        department_id: relation.department_id,
        writable: true
      )
  end

  def set_condition
    condition = ""
    filter_hash = {}
    if params[:keyword]!="" && params[:keyword]!=nil
      condition += "(issue LIKE :keyword OR issue LIKE :keyword OR effect LIKE :keyword)"
      filter_hash[:keyword] = '%' + params[:keyword] +'%'
    end

    if params[:filter_start_date]!="" && params[:filter_end_date]!="" && params[:filter_start_date]!=nil && params[:filter_end_date]!=nil
      condition = set_connection(condition)
      condition += "created_at BETWEEN :start_date AND :end_date"
      filter_hash[:start_date] = params[:filter_start_date]
      filter_hash[:end_date] = params[:filter_end_date].to_date+1
    elsif params[:filter_start_date]!="" && params[:filter_start_date]!=nil
      condition = set_connection(condition)
      condition += "created_at >= :start_date"
      filter_hash[:start_date] = params[:filter_start_date]
    elsif params[:filter_end_date]!="" && params[:filter_end_date]!=nil
      condition = set_connection(condition)
      condition += "created_at <= :end_date"
      filter_hash[:end_date] = params[:filter_end_date].to_date+1
    end

    if params[:filter_location]!="0" && params[:filter_location]!=nil
      condition = set_connection(condition)
      condition += "location_id = :filter_location"
      filter_hash[:filter_location] = params[:filter_location]
    end

    if params[:filter_department]!="0" && params[:filter_department]!=nil
      condition = set_connection(condition)
      condition += "department_id = :filter_department"
      filter_hash[:filter_department] = params[:filter_department]
    end

    if params[:filter_score]!="0" && params[:filter_score]!=nil
      condition = set_connection(condition)
      if params[:filter_score]=="1"
        condition += "NOT EXISTS  (SELECT evaluations.* FROM evaluations"
        condition += " WHERE evaluations.suggestion_id = suggestions.id)"
      else
        condition += "EXISTS (SELECT evaluations.* FROM evaluations"
        condition += " WHERE evaluations.suggestion_id = suggestions.id"
        condition += " AND evaluations.evaluation_score >= :filter_score)"
        filter_hash[:filter_score] = params[:filter_score]
      end
    end

    if params[:filter_result]!="0" && params[:filter_result]!=nil
      condition = set_connection(condition)
      if params[:filter_result]=="99"
        condition += "NOT EXISTS (SELECT results.id FROM evaluations"
        condition += " RIGHT JOIN results ON evaluations.id = results.evaluation_id"
        condition += " WHERE evaluations.suggestion_id = suggestions.id)"
      else
        condition += "EXISTS (SELECT results.id FROM evaluations"
        condition += " RIGHT JOIN results ON evaluations.id = results.evaluation_id"
        condition += " WHERE evaluations.suggestion_id = suggestions.id"
        condition += " AND results.result_list_id = :filter_result)"
        filter_hash[:filter_result] = params[:filter_result]
      end
    end

    return condition, filter_hash
  end

  def set_connection(condition)
    if condition.length > 0
      condition += " AND "
    end
    return condition
  end

end
