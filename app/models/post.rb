class Post < ApplicationRecord
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true 
  alias_attribute :active?, :activated_at

  def self.active
    Post.where('activated_at IS NULL OR activated_at < ?', 10.seconds.ago)
  end

  def active=(value)
    self.activated_at = (Time.current if value)
  end
end
