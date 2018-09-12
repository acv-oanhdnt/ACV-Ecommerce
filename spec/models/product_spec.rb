require 'rails_helper'

RSpec.describe Product, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:img_url) }
    it { should validate_presence_of(:price) }
    it do
      should validate_numericality_of(:price).
        is_greater_than(0)
    end
  end

  context "associations" do
    it { should belong_to(:category) }
  end
end
