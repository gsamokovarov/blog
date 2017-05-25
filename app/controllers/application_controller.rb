class ApplicationController < ActionController::Base
  include Pagination

  respond_to :html, :json
end
