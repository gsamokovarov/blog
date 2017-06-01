AuthenticationMiddleware.secret = begin
  envar = ENV.fetch('SECRET_KEY_BASE').presence

  if Rails.env.development? || Rails.env.test?
    envar.presence || 'test1234'
  else
    unless envar.presence
      abort "You need to specify a SECRET_KEY_BASE environment variable"
    end
  end

  envar
end
