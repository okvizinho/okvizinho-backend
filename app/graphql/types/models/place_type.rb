module Types
  class Models::PlaceType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :description, String, null: true
    field :city, Types::Models::CityType, null: true
    field :district, String, null: true
    field :cover_image, Types::Models::AttachmentType, null: true
    field :is_active, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def cover_image
      return unless object.cover_image&.attached?
      object.cover_image
    end
  end
end
