class UserController < ApplicationController

  def register
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {status: true, user: @user, token: token}, status: :created
    else
      render json: {status: false, error: @user.errors}, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        token = encode_token({user_id: @user.id})
        render json: {status: true, user: @user, token: token}, status: :ok
      else
        render json: {status: false, error: "Credentials not match!"}, status: :forbidden
      end
    else
      render json: {status: false, error: "Email not found"}, status: :forbidden
    end
  end

  private
  def user_params
    role = { role: 'user' }
    params.permit(:email, :password).merge(role)
  end
end
