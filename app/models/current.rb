class Current
  thread_mattr_accessor :user

  def self.reset
    self.user = nil
  end

  module Reset
    extend ActiveSupport::Concern

    included do
      prepend_before_action { Current.reset }
    end
  end
end
