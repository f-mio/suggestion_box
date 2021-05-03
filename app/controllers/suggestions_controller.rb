class SuggestionsController < ApplicationController
#  before_action :set_user, only: [:index, :new, :show, :edit, :create, :destroy]
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :validate_suggestion_state, only: [:edit, :update, :destroy]


  def index
    sql = "SELECT * FROM suggestions ORDER BY created_at desc"
    @suggestions = Suggestion.find_by_sql(sql)
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

  private

  # 消す
  def set_user
    @user = User.find(current_user.id)
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def validate_suggestion_state
    unless user_signed_in? && current_user.id==@suggestion.user_id && @suggestion.writable
      redirect_to root_path
    end
  end

  #投稿機能実装時に入れ込む
  def suggestion_params
    sql = "SELECT * FROM user_departments_relations WHERE user_id = #{current_user.id} ORDER BY department_id;"
    relation = UserDepartmentsRelation.find_by_sql(sql).first
    return params.require(:suggestion).permit(
        :title, :issue, :ideal, :category_id,
        :location_id, :place_id, :target,
        :effect, before_images: [], after_images: []
      ).merge(user_id: current_user.id,
        department_id: relation.department_id,
        writable: true
      )
  end
end
