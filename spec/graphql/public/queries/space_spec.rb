require 'rails_helper'

RSpec.describe 'Space Query' do
  let(:query) do
    '
      query TestSpaceQuery($id: ID!){
        space(id: $id) {
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
    '
  end

  it 'brings a space given its id' do
    space = FactoryBot.create(:space)

    result = PublicSchema.execute(query, context: {}, variables: { id: space.id })

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'space')

    expect(data['id']).to eql(space.id.to_s)
    expect(data['title']).to eql(space.title)
    expect(data['description']).to eql(space.description)
    expect(data['kind']).to eql(space.kind)
    expect(data['district']).to eql(space.district)
    expect(data['isActive']).to eql(space.is_active)
    expect(data['city']['id']).to eql(space.city.id.to_s)
    expect(data['coverImage']['url']).to be_present
  end
end
