class MemeSerializer < ActiveModel::Serializer
  attributes :id, :name, :started_at, :emoji, :medium, :description
end
