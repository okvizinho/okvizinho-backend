FactoryBot.define do
  factory :space do
    place
    user
    sequence(:title) { |i| "Espaço #{i}" }
    description { FFaker::LoremBR.paragraph }
    kind { :parking }
    is_active { true }
    highlight { false }
    dimensions { '3m largura x 7m comprimento' }
    cover_image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/garage.png'), 'image/png')
    end
  end
end
