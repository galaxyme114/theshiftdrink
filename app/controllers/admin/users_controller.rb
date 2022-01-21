class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update, :destroy]

  load_and_authorize_resource
  
  # => GET /users
  def index
    @users = User.staff.order(:name)
  end
  
  # => GET /users/new
  def new
    @user = User.new
  end
  
  # => POST /users
  def create
    @user = User.new user_params.merge(password: 'password1234')

    if @user.save
      redirect_to users_path, notice: 'User was successfully created'
    else
      flash.now[:danger] = @user.first_error_message
      render :new
    end
  end

  # => GET /users/:id/edit
  def edit
  end

  # => PATCH /users/:id
  def update
    params[:user].delete(:role) if current_user == @user

    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated'
    else
      flash.now[:danger] = @user.first_error_message
      render :edit
    end
  end

  # => DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully removed'
  end

  protected
    def user_params
      params.require(:user).permit(:name, :title, :email, :role)
    end

    def find_user
      @user = User.find params[:id]
    end
end
