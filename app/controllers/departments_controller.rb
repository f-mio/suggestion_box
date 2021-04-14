class DepartmentsController < ApplicationController
  before_action :validate_user

  # インデックスページがメンテナンスページに対応
  def index
  end

  def create
  end

  private
  def validate_user
    sql = "SELECT * FROM user_departments_relations ¥
              WHERE is_root_user = true"
    count_root_users = UserDepartmentsRelation.find_by_sql(sql).count

    sql = "SELECT * FROM user_departments_relations ¥
              WHERE user_id = #{current_user.id}"
    relation = UserDepartmentsRelation.find_by_sql(sql)
    unless count_root_users > 0 && current_user.id == 1
      redirect_to root_path
    elsif relation.is_root_user
      redirect_to root_path
    end
  end
end