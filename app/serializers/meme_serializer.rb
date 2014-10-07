class MemeSerializer < ActiveModel::Serializer
  attributes :id, :name, :started_at, :emoji, :medium, :description, :created_at, :updated_at
end
