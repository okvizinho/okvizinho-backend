# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Create user' do
    it 'create a client user' do
      user = FactoryBot.build(:user)

      expect(user).to be_valid
    end
  end
end
