class PriceSetting < ApplicationRecord
  belongs_to :shipping_company
  validates :min_weight, :max_weight, :min_cubic_meter, :max_cubic_meter , :distance_value, presence: true
end
