require 'rails_helper'

RSpec.describe 'Place Query' do
  let(:query) do
    '
      query TestPlaceQuery($id: ID!){
        place(id: $id) {
          id
          title
          description
          district
          isActive
          city {
            id
            name
          }
          coverImage {
            url
          }
        }
      }
    '
  end

  it 'brings a place given its id' do
    place = FactoryBot.create(:place)

    result = PublicSchema.execute(query, context: {}, variables: { id: place.id })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'place')

    expect(data['id']).to eql(place.id.to_s)
    expect(data['title']).to eql(place.title)
    expect(data['description']).to eql(place.description)
    expect(data['district']).to eql(place.district)
    expect(data['isActive']).to eql(place.is_active)
    expect(data['city']['id']).to eql(place.city.id.to_s)
    expect(data['coverImage']['url']).to be_present
  end
end
