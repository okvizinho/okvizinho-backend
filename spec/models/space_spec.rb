# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Space, type: :model do
  describe 'Create space' do
    it 'create a space' do
      space = FactoryBot.build(:space)

      expect(space).to be_valid
    end
  end
end
