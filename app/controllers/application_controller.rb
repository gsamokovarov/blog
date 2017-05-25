class ApplicationController < ActionController::Base
  include Pagination
  include Authentication

  use AuthenticationMiddleware

  respond_to :html, :json
end
