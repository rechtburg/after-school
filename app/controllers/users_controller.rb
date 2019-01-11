class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.point = 1500
    if @user.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(@current_user.id)
  end

  def update
    logger.debug('update params')
    logger.debug(user_params.inspect)
    @user = signed_in? ? @current_user : User.find_by(email: user_params[:email])
    @user.name = user_params[:name] if user_params[:name]
    @user.email = user_params[:email] if user_params[:email]
    @user.password = user_params[:password]
    @user.password_confirmation = user_params[:password_confirmation]
    @user.univercity = user_params[:univercity] if user_params[:univercity]
    @user.faculty = user_params[:faculty] if user_params[:faculty]
    @user.image = user_params[:image] if user_params[:image]

    if @user.save
      flash[:notice] = "Successfully Updated"
      redirect_to mypage_path
   else
     render :show
   end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :university, :faculty, :image)
    end

end