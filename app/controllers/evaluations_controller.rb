class EvaluationsController < ApplicationController
  before_action :validate_users
  before_action :set_suggestions
  before_action :set_suggestion, only: [:new, :create, :edit, :destroy]
  before_action :set_evaluation, only: [:edit, :update]

  def index
  end

  def new
    @evaluation = Evaluation.new
  end

  def create
    # Teamsへ通知を投げるようなものを入れる
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.valid?
      Suggestion.update(@suggestion.id, writable: false)
      @evaluation.save
      redirect_to evaluations_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @evaluation.update(evaluation_params)
      @evaluation.save
      redirect_to suggestion_path(params[:suggestion_id])
    else
      render :edit
    end
  end

  def destroy
    @suggestion.evaluation.destroy
    Suggestion.update(@suggestion.id, writable: true)
    redirect_to suggestion_path(@suggestion.id)
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(
      :comment, :evaluation_score
    ).merge(user_id: current_user.id, suggestion_id: params[:suggestion_id])
  end

  def validate_users
    # 管理職またはroot以外を弾く処理
    relations = UserDepartmentsRelation.where("user_id = #{current_user.id} AND is_manager = True")
    unless current_user.id == 1 || relations.length > 0
      redirect_to root_path
    end
  end

  def set_suggestions
    relations = UserDepartmentsRelation.where("user_id = #{current_user.id}")

    # 制約条件の設定
    conditions = ""
    relations.each_with_index do |relation, idx|
      if idx==0
        conditions = "WHERE (department_id = #{relation.department_id} "
      else
        conditions += "or department_id = #{relation.department_id} "
      end
    end
    conditions += ") AND writable = true "

    sql = "SELECT suggestions.* FROM suggestions " + conditions + "ORDER BY suggestions.created_at ASC;"
    @suggestions = Suggestion.find_by_sql(sql)
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:suggestion_id])
  end

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def notification_to_teams
  # createアクションの際に通知をteamsに投げる
  # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/what-are-webhooks-and-connectors
  # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook
  end

end
