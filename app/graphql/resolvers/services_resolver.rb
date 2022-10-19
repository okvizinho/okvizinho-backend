module Resolvers
  class ServicesResolver < Resolvers::BaseSearchResolver
    include SearchObject.module(:graphql)

    description 'search for services'

    type Types::Models::ServiceType.connection_type, null: true

    class ServicesSearchTerms < ::Types::BaseInputObject
      argument :title, String, required: false
      argument :category_ids, [ID], required: false
      argument :in_promo, Boolean, required: false
    end

    option :where, type: ServicesSearchTerms, with: :apply_conditions

    scope do
      Service.active.order(id: :desc)
    end

    def new_empty_search
      Service.where({})
    end

    def title_condition(scope, title)
      scope.where('title ilike ?', escape_search_term(title))
    end

    def category_ids_condition(scope, category_ids)
      scope.left_joins(:service_categories).where(service_categories: { category_id: category_ids }).where.not(service_categories: {id: nil})
    end

    def in_promo_condition(scope, in_promo)
      if in_promo
        scope.where.not(promo_price: nil)
      else
        scope.where(promo_price: nil)
      end
    end
  end
end
