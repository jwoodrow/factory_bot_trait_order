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
