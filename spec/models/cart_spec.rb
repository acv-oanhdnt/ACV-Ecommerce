require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'association' do
    it { should belong_to(:user) }
  end
end
