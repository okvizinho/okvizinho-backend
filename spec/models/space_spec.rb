# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Space, type: :model do
  describe 'Create space' do
    it 'create a space' do
      space = FactoryBot.create(:space)

      expect(space).to be_valid
      expect(space.cover_image_url).to be_present
    end
  end
end
