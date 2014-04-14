class ClimbsController < ApplicationController
  
  def index
    @climbs = Climb.all.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def edit
  end
  
  def show
  end

  def update
  end
end
