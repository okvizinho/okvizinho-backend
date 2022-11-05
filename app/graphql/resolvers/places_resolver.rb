module Resolvers
  class PlacesResolver < Resolvers::BaseSearchResolver
    include SearchObject.module(:graphql)

    description 'search for places'

    type Types::Models::PlaceType.connection_type, null: true

    class PlacesSearchTerms < ::Types::BaseInputObject
      argument :city_id, ID, required: false
      argument :title, String, required: false
    end

    option :where, type: PlacesSearchTerms, with: :apply_conditions

    scope do
      Place.active
    end

    def new_empty_search
      Place.active.where({})
    end

    def title_condition(scope, title)
      scope.where('title ilike ?', escape_search_term(title))
    end

    def city_id_condition(scope, value)
      scope.where(city_id: value)
    end
  end
end
