module Types
  module Public
    class MutationType < Types::BaseObject
      field :user_signup, mutation: Mutations::Public::UserSignup
      field :recovery_password, mutation: Mutations::Public::RecoveryPassword
    end
  end
end
