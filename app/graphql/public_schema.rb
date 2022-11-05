require 'search_object'
require 'search_object/plugin/graphql'
class PublicSchema < GraphQL::Schema
  mutation(Types::Public::MutationType)
  query(Types::Public::QueryType)
end
