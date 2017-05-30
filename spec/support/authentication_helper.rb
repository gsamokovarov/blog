module AuthenticationHelper
  def auth(user)
    { 'Authorization' => "Bearer #{Authentication.issue(user)}" }
  end
end
