FactoryBot.define do
  factory :user do
    name { FFaker::NameBR.name }
    email { FFaker::Internet.disposable_email }
    phone { FFaker::PhoneNumberBR.phone_number }
    password { '123456' }
  end
end
