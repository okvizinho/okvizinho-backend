require 'rails_helper'

RSpec.describe 'City Query' do
  let(:query) do
    '
      query TestCityQuery($id: ID!){
        city(id: $id) {
          id
          isActive
          name
          uf
        }
      }
    '
  end

  it 'brings a city given its id' do
    city = FactoryBot.create(:city)

    result = PublicSchema.execute(query, context: {}, variables: { id: city.id })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'city')

    expect(data['id']).to eql(city.id.to_s)
    expect(data['name']).to eql(city.name)
  end
end
