FactoryBot.define do
  factory :address do
    street { 'some street' }
    user { association(:user, address: instance) }
  end
end
