class ActivitySerializer < ActiveModel::Serializer
  belongs_to :user

  attributes :id, :date, :name, :minutes, :notes, :yoga_type, :workout, :distance
end
