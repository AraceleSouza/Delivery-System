class ServiceOrder < ApplicationRecord
  belongs_to :shipping_company
  belongs_to :vehicle
  belongs_to :product_model
  enum status: {pending: 0, delivered: 5, canceled: 9 }
end
