require 'rails_helper'

RSpec.describe 'Spaces Query' do
  let(:query) do
    '
      query TestSpacesQuery($where: SpacesSearchTerms){
        spaces(where: $where) {
          nodes {
            id
            title
            description
            district
            isActive
            kind
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

  it 'brings all spaces filter by title' do
    space1 = FactoryBot.create(:space, title: 'space A')
    space2 = FactoryBot.create(:space, title: 'space C')
    space3 = FactoryBot.create(:space, title: 'space B')

    result = PublicSchema.execute(query, context: {}, variables: { where: { title: 'space C' } })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'spaces', 'nodes')

    expect(data.size).to eql(1)
    expect(data[0]['id']).to eql(space2.id.to_s)
    expect(data[0]['title']).to eql(space2.title)
  end

  it 'search by city' do
    space1 = FactoryBot.create(:space, title: 'Cond. Prada')
    space2 = FactoryBot.create(:space, title: 'Cond. Andorinha')
    space3 = FactoryBot.create(:space, title: 'Residencial Campos do Jordão')

    result = PublicSchema.execute(query, variables: { where: { cityId: space3.city.id } })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    response = result.dig('data', 'spaces', 'nodes')

    expect(response.count).to eql(1)
    expect(response[0]['id']).to eql(space3.id.to_s)
    expect(response[0]['title']).to eql(space3.title.to_s)
  end
end
