class Department < ApplicationRecord
  has_many :user, through: :user_departments_relations
end
