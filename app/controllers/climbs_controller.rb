class ClimbsController < ApplicationController
  
  def index
    @climbs = Climb.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def edit
  end
  
  def show
    @climb = Climb.find(params[:id])
  end

  def update
  end
end
