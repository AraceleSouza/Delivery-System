class Vehicle < ApplicationRecord
  belongs_to :shipping_company
  validates :plate, :brand, :year_fabrication, :model, :freight, presence: true
end
