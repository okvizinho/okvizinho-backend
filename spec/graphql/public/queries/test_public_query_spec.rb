require 'rails_helper'

RSpec.describe 'State Query' do
  let(:query) do
    '
      query TestStateQuery {
        test
      }
    '
  end

  it 'brings a state given its id' do

    result = PublicSchema.execute(query, context: {}, variables: {})

    expect(result['errors']).to(be_blank, result['errors'])
    expect(result['data']).to be_present

    data = result.dig('data')

    expect(data['test']).to eql('oi')
  end

end
