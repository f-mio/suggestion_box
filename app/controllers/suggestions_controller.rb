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
#    unless @suggestion.writable
#      redirect_to root_path
#    end
#    if Suggestion.update(@suggestion)
#      redirct_to suggestion_path(@suggestion.id)
#    else
#      render :edit
#    end
  end


  private

  def set_user
    @user = User.find(current_user.id)
  end

  #投稿機能実装時に入れ込む
  def suggestion_param
    params.require(:suggestion).permit(:title,
        :issue, :ideal, :category_id,
        :location_id, :place_id, :target,
        :effect, before_images: [], after_images: []
      ).merge(user_id: current_user.id,
        department_id: current_user.department.id,
        writabele: true)
  end
end
