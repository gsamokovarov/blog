class PostSerializer < ApplicationSerializer
  attributes :id, :description, :active

  def active
    !!object.activated_at
  end
end
