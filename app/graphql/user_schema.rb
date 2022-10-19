class UserSchema < GraphQL::Schema
  mutation(Types::User::MutationType)
  query(Types::User::QueryType)
end
