class MemeSerializer < ActiveModel::Serializer
  attributes :id, :name, :funny, :emoji_pattern, :description
end
