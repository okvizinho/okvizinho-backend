require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'create and edit admin' do

    it 'factory is valid' do
      expect(FactoryBot.build(:admin)).to be_valid
    end

    it 'create_admin' do
      params = { name: 'name', email: 'admin@gmail.com', password: '123456' }

      admin = Admin.create!(params)

      expect(admin.email).to be_present
      expect(admin.valid_password?('123456')).to be true
    end

    it 'edit admin' do
      admin = FactoryBot.create(:admin, email: 'admin@gmail.com', password: '123456')

      params = { email: 'admin@gmail.com', password: '654321' }

      expect(admin.update(params)).to be true
      expect(admin.password).to eql '654321'
    end
  end
end
