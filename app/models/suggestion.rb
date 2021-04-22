class Suggestion < ApplicationRecord
  belongs_to :user
  has_many_attached :before_images
  has_many_attached :after_images

  #validate
  # with_options presense: true do
  # end
  #validates

  def was_attached?
  end

end