class Product < ApplicationRecord
  belongs_to :category, optional: true

  validates :name, :description, :img_url, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true 
end
