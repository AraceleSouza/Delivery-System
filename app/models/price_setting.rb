class PriceSetting < ApplicationRecord
  belongs_to :shipping_company
  validates :min_weight, :max_weight, :min_cubic_meter, :max_cubic_meter , :distance_value, :shipping_company, presence: true
  validates :min_weight, numericality: { greater_than_or_equal_to: 0.10 }
  validates :max_weight, numericality: { greater_than_or_equal_to: 0.50 }
  validates :max_weight, comparison: { greater_than: :min_weight}
end
