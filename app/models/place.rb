class Place < ApplicationRecord
  belongs_to :location
  has_many   :suggestions
end
