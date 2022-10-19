module Types
  module User
    class QueryType < Types::Public::QueryType
      field :me, Types::Models::UserType, null: false

      def me
        context[:current_user]
      end
    end
  end
end
