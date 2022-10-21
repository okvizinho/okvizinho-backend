module Types
  class Models::CityType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :uf, String, null: true
    field :is_active, Boolean, null: true
  end
end
