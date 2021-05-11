class Result < ApplicationRecord

  # Association
  belongs_to :evaluation
  belongs_to :result_list
  belongs_to :user

  # Validation
  validates :comment, presence: true
  validates :result_list_id, numericality: {only_integer: true, other_than: 0}
end
