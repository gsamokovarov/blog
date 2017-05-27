class UsersController < ApplicationController
  def create
    user = User.create!(user_params) do |user|
      UserMailer.registration_mail(user).deliver_now
    end

    respond_with user, serializer: UserTokenSerializer, location: nil
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
