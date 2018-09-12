require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:shipping_address) }
    it { should validate_presence_of(:email) }
  end
  context 'association' do
    it { should belong_to(:user) }
  end
end
