class Evaluation < ApplicationRecord

  # Association
  belongs_to :suggestion
  belongs_to :user
  has_one    :result

  # Validation
  validates :comment, presence: true
  validates :evaluation_score, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
end
