require 'rails_helper'

RSpec.describe 'User Signup' do
  let(:app) { Doorkeeper::Application.create!({ name: 'Test API', redirect_uri: 'urn:ietf:wg:oauth:2.0:oob' }) }
  let(:business_segment) { FactoryBot.create(:business_segment) }
  let(:query) {
    '
      mutation TestUserSignup($input: UserSignupInput!) {
        userSignup(input: $input) {
          user {
            id
            name
            email
          }
          token {
            accessToken
          }
          errors
        }
      }
    '
  }


  it 'creates a new User' do

    params = {
      name: 'User 1',
      email: 'user@email.com',
      password: '123456',
      passwordConfirmation: '123456'

    }

    result = PublicSchema.execute(query, context: {doorkeeper_app: app}, variables: { input: params })
    
    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    expect(User.count).to be 1

    data = result.dig('data', 'userSignup', 'user')

    user = User.find(data['id'])
    expect(user.name).to eql data['name']
    expect(user.email).to eql data['email']
    expect(user.valid_password?(params[:password]))

    access_token = result.dig('data', 'userSignup', 'token', 'accessToken')
    expect(access_token).to be_present

    token = Doorkeeper::AccessToken.find_by(token: access_token)
    expect(token).to be_present

    expect(token.application).to eql app
    expect(token.resource_owner_id).to eql(user.id)
    expect(token).to be_valid
  end
end
