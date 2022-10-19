module Resolvers
  class ServiceRequestsResolver < Resolvers::BaseSearchResolver
    include SearchObject.module(:graphql)

    description 'search for service requests'

    type Types::Models::ServiceRequestType.connection_type, null: true

    class ServiceRequestsSearchTerms < ::Types::BaseInputObject
      argument :title, String, required: false
      argument :category_ids, [ID], required: false
    end

    option :where, type: ServiceRequestsSearchTerms, with: :apply_conditions

    scope do
      ServiceRequest.active.not_full.ongoing.oldest
    end

    def new_empty_search
      ServiceRequest.active.not_full.oldest.where({})
    end

    def title_condition(scope, title)
      scope.joins(:service).where('services.title ilike ?', escape_search_term(title))
    end

    def category_ids_condition(scope, category_ids)
      scope.left_joins(:service_categories).where(service_categories: { category_id: category_ids }).where.not(service_categories: {id: nil})
    end
  end
end
