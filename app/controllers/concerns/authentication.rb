module Authentication
  extend ActiveSupport::Concern

 included do
    use AuthenticationMiddleware
  end

  def self.issue(user)
    JWT.encode(
      {sub: user.id},
      AuthenticationMiddleware.secret,
      AuthenticationMiddleware.alg)
  end

  private

  def authenticate
    token = request.env['blog.token']

    if token.nil?
      render json: {error: :unauthenticated}, status: :unauthorized
    else
      Current.user = User.find(token['sub'])
    end
  end
end
