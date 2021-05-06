class Result < ApplicationRecord

  # Association
  belongs_to :evaluation
  belongs_to :result_list
  belongs_to :user
  belongs_to :department_id

  # Validation
end
