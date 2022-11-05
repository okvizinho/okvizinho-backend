module Types
  module Public
    class QueryType < Types::BaseObject
      field :test, String, null: false

      def test
        'oi'
      end

      field :cities, Types::Models::CityType.connection_type, null: true do
        argument :name, String, required: false
      end

      def cities(args = {})
        scope = City.active
        scope = scope.where('name ILIKE ?', "%#{args[:name]}%") if args[:name].present?

        scope.order(name: :asc)
      end

      field :city, Types::Models::CityType, null: true do
        argument :id, ID, required: true
      end

      def city(args)
        City.find_by(id: args[:id])
      end

      field :spaces, resolver: Resolvers::SpacesResolver

      field :space, Types::Models::SpaceType, null: true do
        argument :id, ID, required: true
      end

      def space(args)
        Space.active.find_by(id: args[:id])
      end
    end
  end
end
