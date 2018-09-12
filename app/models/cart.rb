class Cart < ApplicationRecord
  belongs_to :user
  before_save :check_data

  def check_data
    if data.blank?
      errors.add(:data, 'can\'t be blank')
      throw(:abort)
    end
    _data = JSON.parse(data)
    begin
      Product.where(_data.keys)
    rescue StandardError
      errors.add('cant find product id')
      throw(:abort)
    end
  end
end
