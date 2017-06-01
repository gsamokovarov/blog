class AuthenticationMiddleware
  TOKEN_EXTRACT_RE = /^Bearer\s+(.+)$/

  cattr_accessor(:secret)
  cattr_accessor(:alg) { 'HS256' }

  def initialize(app)
    @app = app
  end

  def call(env)
    env['blog.token'] = verify_token(env)

    @app.call(env)
  rescue JWT::DecodeError
    [401, {}, [{error: :unauthorized}.to_json]]
  end

  private

  def verify_token(env)
    env['HTTP_AUTHORIZATION']&.match(TOKEN_EXTRACT_RE) { |md| decode_token(md[1]) }
  end

  def decode_token(token)
    JWT.decode(token, secret, true, algorithm: alg).first
  end
end
