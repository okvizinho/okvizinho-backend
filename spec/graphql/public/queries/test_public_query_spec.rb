require 'rails_helper'

RSpec.describe 'Test Query' do
  let(:query) do
    '
      query TestQuery {
        test
      }
    '
  end

  it 'brings a test given its id' do

    result = PublicSchema.execute(query, context: {}, variables: {})

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data')

    expect(data['test']).to eql('oi')
  end

end
