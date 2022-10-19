require 'rails_helper'

RSpec.describe 'me query' do
  let(:query) do
    '
      query TestMeQuery{
        me {
          id
          name
          email
        }
      }
    '
  end

  it 'get user professional info' do
    user = FactoryBot.create(:user)

    result = UserSchema.execute(query, context: { current_user: user }, variables: {})

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data', 'me')

    expect(data['id']).to eql(user.id.to_s)
    expect(data['name']).to eql(user.name)
    expect(data['email']).to eql(user.email)
  end
end
