class Suggestion < ApplicationRecord

  # Association
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :department
  belongs_to :category
  belongs_to :location
  belongs_to :place
  has_many_attached :before_images
  has_many_attached :after_images
  has_one :evaluation

  # Validation
  with_options presence: true do
    validates :title, :issue, :ideal, :target, :effect
    with_options numericality: {only_integer: true, other_than: 0} do
      validates :location_id, :place_id, :category_id
    end
  end

end