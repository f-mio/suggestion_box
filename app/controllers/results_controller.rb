class ResultsController < ApplicationController
  before_action :validate_user_from_index, only: :index
  before_action :validate_user, except: :index
  before_action :set_suggestions

  def index
  end

  private

  def validate_user_from_index
    ### 親部署の一覧を取得　→　該当ユーザが管理者かつ親部署に所属していることをrelationから調査する。

    # 親部署一覧の取得
    parent_ids = Department.pluck("DISTINCT parent_id")

    sql = "SELECT * FROM user_departments_relations "
    sql += "WHERE user_id = #{current_user.id} "
    parent_ids.each_with_index do |parent_id, idx|
      if idx == 0
        sql += "AND ( department_id = #{parent_id} "
      else
        sql += "OR department_id = #{parent_id} "
      end
    end
    sql += ") AND is_manager = true;"

    relations = UserDepartmentsRelation.find_by_sql(sql)
    unless relations.length > 0
      redirect_to root_path
    end
  end

  def set_suggestions
  end

  def set_suggestion
  end
end
