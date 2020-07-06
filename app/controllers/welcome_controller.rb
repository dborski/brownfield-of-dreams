class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag])
      @tutorials = @tutorials.where(classroom: false) unless current_user
      @tutorials = @tutorials.paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all
      @tutorials = @tutorials.where(classroom: false) unless current_user
      @tutorials = @tutorials.paginate(page: params[:page], per_page: 5)
    end
  end
end
