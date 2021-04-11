class SuggestionsController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
  end

  def show
  end

  def edit
  end
end
