class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :active

  def text
    object.description
  end

  def active
    !!object.activated_at
  end
end
