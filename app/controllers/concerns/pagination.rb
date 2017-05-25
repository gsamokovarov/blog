module Pagination
  extend ActiveSupport::Concern

  private

  def page_number
    pagination_params[:number]
  end

  def page_size
    pagination_params[:size]
  end

  def pagination_params
    (params[:page] || {}).tap do |p|
      p[:number] ||= 1
      p[:size]   ||= 10
    end
  end
end
