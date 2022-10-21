require 'rails_helper'

RSpec.describe 'Cities Query' do
  let(:query) do
    '
      query TestCitiesQuery($name: String){
        cities(name: $name) {
          nodes {
            id
            isActive
            name
            uf
          }
        }
      }
    '
  end

  it 'brings all cities order name asc' do
    city1 = FactoryBot.create(:city, name: 'City A')
    city2 = FactoryBot.create(:city, name: 'City C')
    city3 = FactoryBot.create(:city, name: 'City B')

    result = PublicSchema.execute(query, context: {}, variables: {})

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'cities', 'nodes')

    expect(data.size).to eql(3)
    expect(data[0]['id']).to eql(city1.id.to_s)
    expect(data[0]['name']).to eql(city1.name)

    expect(data[1]['id']).to eql(city3.id.to_s)
    expect(data[1]['name']).to eql(city3.name)

    expect(data[2]['id']).to eql(city2.id.to_s)
    expect(data[2]['name']).to eql(city2.name)
  end

  it 'search by name' do
    city1 = FactoryBot.create(:city, name: 'Prada')
    city2 = FactoryBot.create(:city, name: 'Andorinha')
    city3 = FactoryBot.create(:city, name: 'Campos do Jordão')

    result = PublicSchema.execute(query, variables: { name: 'Campos' })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    response = result.dig('data', 'cities', 'nodes')

    expect(response.count).to eql(1)
    expect(response[0]['id']).to eql(city3.id.to_s)
    expect(response[0]['name']).to eql(city3.name.to_s)
  end
end
