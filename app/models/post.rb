class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  alias_attribute :active?, :activated_at

  class << self
    def active
      where('activated_at IS NOT NULL AND activated_at < ?', 2.minutes.ago)
    end

    def popular(n = 2)
      where(id: Post.ids.sample(n))
    end
  end

  def active=(value)
    self.activated_at = (Time.current if value)
  end
end
