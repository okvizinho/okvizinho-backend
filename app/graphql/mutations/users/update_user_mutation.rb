module Mutations
  module Users
    class UpdateUserMutation < Mutations::BaseMutation
      argument :name, String, required: false
      argument :email, String, required: false
      argument :password, String, required: false
      argument :password_confirmation, String, required: false

      field :user, Types::Models::UserType, null: true
      field :errors, [String], null: true

      def resolve args
        user = context[:current_user]

        if args[:password].blank?
          args.except! :password
          args.except! :password_confirmation
        end

        if user.public_send :update, args.to_h          
          { user: user }
        else
          { errors: user.errors.full_messages }
        end

      end
    end
  end
end