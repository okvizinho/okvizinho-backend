FactoryBot.define do
  factory :place do
    city
    sequence(:title) { FFaker::Company.name }
    description { FFaker::LoremBR.paragraph }
    is_active { true }
    district { "Centro" }
    cover_image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/space.png'), 'image/png')
    end
  end
end
