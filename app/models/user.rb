class User < ApplicationRecord
  include Storext.model

  enum role: %i[user admin]

  store_attributes :options do
    some_value String
  end

  has_one :address

  validates_presence_of :some_value, if: :admin?
end
