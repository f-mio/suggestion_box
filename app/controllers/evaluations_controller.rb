class EvaluationsController < ApplicationController
  before_action :set_suggestions
  before_action :set_suggestion, only: [:new, :create, :edit]

  def index
  end

  def new
  end

  def create
    # Teamsへ通知を投げるようなものを入れる
  end

  private

  def set_suggestions
    sql = "SELECT * FROM suggestions ORDER BY created_at desc"
    @suggestions = Suggestion.find_by_sql(sql)
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:suggestion_id])
  end

  def notification_to_teams
  # createアクションの際に通知をteamsに投げる
  # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/what-are-webhooks-and-connectors
  # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook
  end
end
