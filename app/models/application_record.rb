class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def previous
    previous_id = Suggestion.where("id < ?", self.id).order("id DESC").first
  end

  def next
    next_id = Suggestion.where("id > ?", self.id).order("id ASC").first
  end

end
