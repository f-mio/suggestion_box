class Place < ApplicationRecord
  belongs_to :location
  has_manu   :suggestions
end
