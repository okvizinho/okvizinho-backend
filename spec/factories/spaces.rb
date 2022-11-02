FactoryBot.define do
  factory :space do
    city
    sequence(:title) { |i| "Espaço #{i}" }
    description { FFaker::LoremBR.paragraph }
    kind { :parking }
    is_active { true }
  end
end
