module Mutations
  module Public
    class RecoveryPassword < Mutations::BaseMutation
      argument :email, String, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: true

      def resolve(params)
        user = User.find_for_database_authentication(email: params[:email])

        user&.send_reset_password_instructions

        { success: true }
      end
    end
  end
end

