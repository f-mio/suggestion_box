class UserDepartmentsRelation < ApplicationRecord
  belongs_to :user
  belongs_to :department

  validates :is_manager, inclusion: {in: [true, false], message: "Bool値を入力して下さい"}
end
