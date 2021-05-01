class SuggestionsController < ApplicationController
  before_action :set_user, only: [:index, :new, :show, :edit, :create]

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
    @suggestion = Suggestion.find(params[:id])
  end

  def edit
#    unless @suggestion.writable
#      redirect_to root_path
#    end
#    if Suggestion.update(@suggestion)
#      redirct_to suggestion_path(@suggestion.id)
#    else
#      render :edit
#    end
  end


  private

  def set_user
    @user = User.find(current_user.id)
  end

  #投稿機能実装時に入れ込む
  def suggestion_params
    sql = "SELECT * FROM user_departments_relations WHERE user_id = #{current_user.id} ORDER BY department_id;"
    relation = UserDepartmentsRelation.find_by_sql(sql)
    return params.require(:suggestion).permit(:title,
        :issue, :ideal, :category_id,
        :location_id, :place_id, :target,
        :effect, before_images: [], after_images: []
      ).merge(user_id: current_user.id,
        department_id: relation[0].department_id,
        writable: true
      )
  end
end
