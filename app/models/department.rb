class Department < ApplicationRecord
  has_many :users, through: :user_departments_relations
end
