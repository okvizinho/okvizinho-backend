module Resolvers
  class BaseSearchResolver < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    def apply_conditions(scope, conditions)
      branches = resolve_branches(conditions).reduce { |a, b| a.or(b) }
      scope.merge(branches)
    end

    def resolve_branches(conditions, branches = [])
      branches << create_where_block(conditions)
      conditions[:OR].reduce(branches) { |s, v| resolve_branches(v, s) } if conditions[:OR].present?
      branches
    end

    def create_where_block(conditions)
      where = new_empty_search

      conditions.each do |name, value|
        method_name = "#{name}_condition"
        where = send(method_name, where, value) if respond_to?(method_name)
      end

      where
    end

    def escape_search_term(term)
      "%#{term.gsub(/\s+/, "%")}%"
    end
  end
end

