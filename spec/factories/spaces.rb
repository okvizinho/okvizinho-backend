FactoryBot.define do
  factory :space do
    city
    sequence(:title) { |i| "Espaço #{i}" }
    description { FFaker::LoremBR.paragraph }
    kind { :parking }
    is_active { true }
    district { "Centro" }
    cover_image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/space.png'), 'image/png')
    end
  end
end
