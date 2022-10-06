FactoryBot.define do
  factory :admin do
    sequence(:name) { |i| "Admin #{i}" }
    sequence(:email) { |i| "admin#{Time.now.to_i}#{i}@test.com" }
    password { '123456' }
  end
end
