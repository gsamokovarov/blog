module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |err|
      # We do this, because AMS is smart enough to render the proper JsonApi
      # error response for invalid records.
      respond_with err.record
    end
  end
end
