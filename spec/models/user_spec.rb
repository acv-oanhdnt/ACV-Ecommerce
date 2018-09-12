require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_one(:cart) }
    it { should have_many(:orders) }
  end
end