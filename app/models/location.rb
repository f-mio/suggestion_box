class Location < ApplicationRecord
  has_many :places
  has_many :suggestions
end
