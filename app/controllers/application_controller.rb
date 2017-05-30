class ApplicationController < ActionController::API
  include Pagination
  include Authentication
  include ErrorHandling
  include Current::Reset

  respond_to :json
end
