class AlternativePostSerializer < ApplicationSerializer
  attributes :id, :title, :description

  def id
    object&.id
  end

  def title
    object&.title
  end

  def description
    object&.description
  end
end
