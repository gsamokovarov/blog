class PostSerializer < ApplicationSerializer
  attributes :id, :title, :description, :active

  def active
    !!object.activated_at
  end
end
