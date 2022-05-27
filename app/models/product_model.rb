class ProductModel < ApplicationRecord
  belongs_to :shipping_company
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
end
