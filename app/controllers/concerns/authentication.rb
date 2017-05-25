module Authentication
  extend ActiveSupport::Concern

  def self.issue(user)
    JWT.encode(
      {sub: user.id},
      AuthenticationMiddleware.secret,
      AuthenticationMiddleware.alg)
  end

  private

  def authenticate
    @token = request.env['blog.token'] or
      render json: {error: :authenticated}, status: :authenticated
  end
end
