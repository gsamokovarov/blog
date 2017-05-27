class UserTokenSerializer < ApplicationSerializer
  attributes :jwt

  def jwt
    Authentication.issue(object)
  end
end
