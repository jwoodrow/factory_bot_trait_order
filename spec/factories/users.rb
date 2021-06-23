FactoryBot.define do
  factory :user do
    role { :user }

    address { association(:address, user: instance) }

    trait :admin do
      role { :admin }
      some_value { 'present' }
    end
  end
end
