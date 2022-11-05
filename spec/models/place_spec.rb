# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'Create place' do
    it 'create a place' do
      place = FactoryBot.create(:place)

      expect(place).to be_valid
      expect(place.cover_image_url).to be_present
    end
  end
end
