module Types
  module User
    class MutationType < Types::BaseObject
      field :update_user, mutation: Mutations::Users::UpdateUserMutation
    end
  end
end
