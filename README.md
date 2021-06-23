# FactoryBot trait error

When creating a factory with a dependent association traits are applied after the association is called thus resulting in some validations not passing that should

How to reproduce:
1. Create a main model with a conditional presence validation
```ruby
class User
  enum role: %i[admin user]
  
  validates_presence_of :some_value, if: :user?
end
```

2. Create a second model linked to the First model
```ruby
class User
# ...
  has_one :address
# ...
end

class Address
  belongs_to :user
end
```

3. Create a factory with a trait to validate the given condition
```ruby
FactoryBot.define do
  factory :user do
    role { :admin }

    address { association(:address, user: instance) }

    trait :user do
      role { :user }
      some_value { 'present' }
    end
  end
end
```

4. Create a simple factory for the second model
```ruby
FactoryBot.define do
  factory :address do
    user { association(:user, address: instance) }
  end
end
```

5. Add some simple specs
```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'without trait' do
    it 'builds' do
      expect(build(:user)).to be_valid
    end

    it 'creates' do
      expect(create(:user)).to be_persisted
    end
  end

  context 'with admin trait' do
    it 'builds' do
      expect(build(:user, :admin)).to be_valid
    end

    it 'creates' do
      expect(create(:user, :admin)).to be_persisted
    end
  end
end
```

6. Run specs
```bash
rails db:migrate
bundle exec rspec
#=> ...F
#=> Failures:

#=>  1) User with admin trait creates
#=>     Failure/Error: address { association(:address, user: instance) }

#=>     ActiveRecord::NotNullViolation:
#=>       PG::NotNullViolation: ERROR:  null value in column "user_id" violates not-null constraint
```
