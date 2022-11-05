require 'rails_helper'

RSpec.describe 'Places Query' do
  let(:query) do
    '
      query TestPlacesQuery($where: PlacesSearchTerms){
        places(where: $where) {
          nodes {
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
      }
    '
  end

  it 'brings all places filter by title' do
    place1 = FactoryBot.create(:place, title: 'place A')
    place2 = FactoryBot.create(:place, title: 'place C')
    place3 = FactoryBot.create(:place, title: 'place B')

    result = PublicSchema.execute(query, context: {}, variables: { where: { title: 'place C' } })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'places', 'nodes')

    expect(data.size).to eql(1)
    expect(data[0]['id']).to eql(place2.id.to_s)
    expect(data[0]['title']).to eql(place2.title)
  end

  it 'search by city' do
    place1 = FactoryBot.create(:place, title: 'Cond. Prada')
    place2 = FactoryBot.create(:place, title: 'Cond. Andorinha')
    place3 = FactoryBot.create(:place, title: 'Residencial Campos do Jordão')

    result = PublicSchema.execute(query, variables: { where: { cityId: place3.city.id } })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    response = result.dig('data', 'places', 'nodes')

    expect(response.count).to eql(1)
    expect(response[0]['id']).to eql(place3.id.to_s)
    expect(response[0]['title']).to eql(place3.title.to_s)
  end
end
