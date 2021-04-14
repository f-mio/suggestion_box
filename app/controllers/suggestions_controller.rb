class SuggestionsController < ApplicationController
  before_action :set_user, only: [:index, :new, :show, :edit]

  def index
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


  private

  def set_user
    @user = User.find(current_user.id)
  end
end
