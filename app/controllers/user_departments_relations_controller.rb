class UserDepartmentsRelationsController < ApplicationController
  before_action :validate_user
  before_action :set_relations, only: [:index, :update]
  before_action :relation_params, only: [:create]

  # インデックスページがメンテナンスページに対応
  def index
  end

  def create
    sql = "SELECT * FROM user_departments_relations "
    sql += "WHERE user_id = #{relation_params[:user_id]} AND department_id = #{relation_params[:department_id]};"
    relation = UserDepartmentsRelation.find_by_sql(sql)
    @relation = UserDepartmentsRelation.new(relation_params)

    # 既にあるものがあった場合、メンテナンストップへ移動
    if relation.count >= 1
      redirect_to user_departments_relations_path
    elsif @relation.valid?
      @relation.save
      redirect_to user_departments_relations_path
    else
      render :new
    end
  end

  def new
    @relation    = UserDepartmentsRelation.new
  end

  def update
  end

  private

  def validate_user
    unless current_user.id == 1
      redirect_to root_path
    end
  end

  def set_relations
    @relations = UserDepartmentsRelation.all.sort_by{ |r| r.department_id}
  end

  def relation_params
    params.require(:user_departments_relation).permit([:user_id, :department_id, :is_manager])
  end

end
