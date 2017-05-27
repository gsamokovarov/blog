class AuthsController < ApplicationController
  def create
    user = User.find_by!(email: user_params[:email])

    if user.authenticate(user_params[:password])
      respond_with user, serializer: UserTokenSerializer, location: nil
    else
      render json: {error: :unauthorized}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
