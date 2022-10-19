module Types
  class Models::UserPushTokenType < Types::BaseObject
    field :id, ID, null: false
    field :token, String, null: true
  end
end
