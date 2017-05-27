class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  alias_attribute :active?, :activated_at

  class << self
    def active
      where('activated_at IS NULL OR activated_at < ?', 10.seconds.ago)
    end

    def popular
      where(id: Post.ids.sample(2))
    end
  end

  def active=(value)
    self.activated_at = (Time.current if value)
  end
end
