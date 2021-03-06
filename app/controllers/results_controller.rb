class ResultsController < ApplicationController
  before_action :validate_user
  before_action :set_url
  before_action :set_suggestions
  before_action :set_suggestion, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_result, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)

    if @result.valid?
      @result.save
      # 審査終了後にTeamsへ通知
      web_hook = ENV['WEBHOOK']
      message  = "[【#{@suggestion.title}】の評価](#{suggestion_path(@suggestion.id)})が終了しました。"
      notification_to_teams(web_hook, message)
      redirect_to results_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @result.update(result_params)
      redirect_to results_path
    else
      render :edit
    end
  end

  def destroy
    @result.destroy
    redirect_to suggestion_path(@suggestion.id)
  end


  private

  def set_url
    @url = request.fullpath
  end

  def validate_user
    ### 親部署の一覧を取得　→　該当ユーザが管理者かつ親部署に所属していることをrelationから調査する。

    # 親部署一覧の取得
    parent_ids = Department.pluck("DISTINCT parent_id")

    sql = "SELECT * FROM user_departments_relations "
    sql += "WHERE user_id = #{current_user.id} "
    sql += "AND department_id IN (:department_ids) "
    sql += "AND is_manager = true;"
    sql = [sql, {department_ids: parent_ids}]

    relations = UserDepartmentsRelation.find_by_sql(sql)
    unless relations.length > 0 || current_user.id == 1
      redirect_to root_path
    end
  end

  def set_suggestions
    department_ids = UserDepartmentsRelation.where(
        "user_id = :user_id AND is_manager = true",
        {user_id: current_user.id }
      ).pluck(:department_id)
    sql = "SELECT suggestions.* FROM evaluations "
    sql += "INNER JOIN suggestions on suggestions.id = evaluations.suggestion_id "
    sql += "WHERE suggestions.department_id IN (:department_ids);"
    sql = [sql, {department_ids: department_ids}]

    @suggestions = Suggestion.find_by_sql(sql)
  end


  def set_suggestion
    @suggestion = Suggestion.find(params[:suggestion_id])
  end

  def set_result
    @result = @suggestion.evaluation.result
  end

  def result_params
    params.require(:result).permit(
        :comment, :result_list_id
      ).merge(
        user_id: current_user.id,
        department_id: @suggestion.department.parent_id,
        evaluation_id: params[:evaluation_id])
  end

  # createアクションの際に通知をteamsに投げる
  def notification_to_teams(web_hook, message)
    uri = URI.parse(web_hook)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type' => 'application/json' })
    request.body = request_body(web_hook, message).to_json

    response = http.start { |h| h.request(request) }
    # https://qiita.com/miyay/items/38a21f00768a19737d12
    # https://tech.stmn.co.jp/entry/2020/09/23/162142
    # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/what-are-webhooks-and-connectors
    # https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook
  end

  def request_body(url, message)
    {
      "@context": "https://schema.org/extensions",
      "@type": "MessageCard",
      "themeColor": "A0C4FF",
      "summary": "summary",
      "sections": [{
        "activityTitle": "提案の審査終了連絡",
        "text": message,
        "markdown": true,
      }]
    }
  end
end
