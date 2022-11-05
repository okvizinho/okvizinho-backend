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

      field :places, resolver: Resolvers::PlacesResolver

      field :place, Types::Models::PlaceType, null: true do
        argument :id, ID, required: true
      end

      def place(args)
        Place.active.find_by(id: args[:id])
      end
    end
  end
end
