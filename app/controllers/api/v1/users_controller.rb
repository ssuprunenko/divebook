class Api::V1::UsersController < Api::BaseController
  before_action :authenticate!
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :return_user, only: :show

  def index
    @users = paginate User.all

    render json: @users, each_serializer: UserSerializer
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      return_user
    elsif @user.invalid?
      unprocessable_entity(@user)
    else
      unexpected_error
    end
  end

  def update
    if @user.update(user_params)
      return_user
    else
      unprocessable_entity(@user)
    end
  end

  def destroy
    return_user if @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def return_user
    render json: @user, serializer: UserSerializer
  end

  def user_params
    params.permit(:name, :email, :password, :access_token)
  end
end
