FactoryBot.define do
  factory :user do
    name { FFaker::NameBR.name }
    email { FFaker::Internet.disposable_email }
    password { '123456' }
  end
end
