FactoryBot.define do
  factory :city do
    name { FFaker::AddressBR.city }
    uf { FFaker::AddressBR.state_abbr }
    is_active { true }
  end
end
