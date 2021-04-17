class UserDepartmentsRelationsController < ApplicationController
  before_action :validate_user

  # インデックスページがメンテナンスページに対応
  def index
    @relations = UserDepartmentsRelation.all
  end

  def create
  end

  def new
    @relation    = UserDepartmentsRelation.new
    @users       = User.all
    @departments = Department.all
  end

  def update
  end

  private
  def validate_user
    unless current_user.id == 1
      redirect_to root_path
    end
  end
end
