FactoryBot.define do
  factory :user do
    type { 'Customer' }
    email { 'test@domain.com' }
    first_name { 'Gerard' }
    last_name { 'Montemayor' }
  end
end
