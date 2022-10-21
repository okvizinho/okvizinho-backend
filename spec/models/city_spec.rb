# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'Create City' do
    it 'create a city' do
      city = FactoryBot.build(:city)

      expect(city).to be_valid
    end
  end
end
