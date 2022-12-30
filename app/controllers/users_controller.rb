class UsersController < ApplicationController
  before_action only: %i[ show update destroy ]

  # GET /users
  def index
    users = User.all

    render json: users
  end

  # GET /users/1
  def show
    
    if current_user
      render json: user, status: :ok
    else
      render json: "Not authenticated", status: :unauthorized
    end
  end

  # POST /users
  def create
    # debugger
    user = User.create(user_params)

    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    # if @user.update(user_params)
    #   render json: @user
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /users/1
  def destroy
    # @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   # debugger
    #   @user = User.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end