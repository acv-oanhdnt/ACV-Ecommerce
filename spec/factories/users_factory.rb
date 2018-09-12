FactoryBot.define do
  factory :user do
    email 'test@test.com'
    password 12345678
    password_confirmation 12345678
    first_name 'User'
    last_name 'Test'
    phone '0897652741'
  end
end
