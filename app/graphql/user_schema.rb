require 'search_object'
require 'search_object/plugin/graphql'
class UserSchema < GraphQL::Schema
  mutation(Types::User::MutationType)
  query(Types::User::QueryType)
end
