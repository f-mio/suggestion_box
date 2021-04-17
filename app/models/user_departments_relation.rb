class UserDepartmentsRelation < ApplicationRecord
  belongs_to :user
  belongs_to :department

  def save
  end
end
