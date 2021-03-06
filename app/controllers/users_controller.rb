class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.first_name}!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @ascents = @user.ascents.paginate(page: params[:page])
    @climbs = @user.climbs.paginate(page: params[:page])
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :gender, :date_of_birth, :password, :password_confirmation)
    end
    
    
    # Before filters

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "Please log in."
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
