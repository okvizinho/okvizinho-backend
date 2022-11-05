module Resolvers
  class SpacesResolver < Resolvers::BaseSearchResolver
    include SearchObject.module(:graphql)

    description 'search for spaces'

    type Types::Models::SpaceType.connection_type, null: true

    class SpacesSearchTerms < ::Types::BaseInputObject
      argument :city_id, ID, required: false
      argument :title, String, required: false
    end

    option :where, type: SpacesSearchTerms, with: :apply_conditions

    scope do
      Space.active
    end

    def new_empty_search
      Space.active.where({})
    end

    def title_condition(scope, title)
      scope.where('title ilike ?', escape_search_term(title))
    end

    def city_id_condition(scope, value)
      scope.where(city_id: value)
    end
  end
end
