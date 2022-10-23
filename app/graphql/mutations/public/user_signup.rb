module Mutations
  module Public
    class UserSignup < Mutations::BaseMutation
      
      argument :name, String, required: true
      argument :email, String, required: true
      argument :phone, String, required: false
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Types::Models::UserType, null: true
      field :token, Types::Models::UserTokenType, null: true
      field :errors, [String], null: true

      def resolve(params)

        user = User.new(params.to_h)

        return { errors: user.errors.full_messages } unless user.save
        
        token = create_access_token_for!(app: context[:doorkeeper_app], user: user)

        { user: user, token: token }
      end

      private 
      
      def create_access_token_for!(app:, user:)
        Doorkeeper::AccessToken.find_or_create_by!({ application: app, resource_owner_id: user.id })
      end
    end
  end
end
