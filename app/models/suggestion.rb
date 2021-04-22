class Suggestion < ApplicationRecord
  belongs_to :user
  has_many_attached :before_images
  has_many_attached :after_images

  with_options presense: true do
    validates :title, 
  end

  def was_attached?
  end

end