class DeliveryRoute < ApplicationRecord
  belongs_to :service_order
  validates :current_address, :exit_address, :current_date, presence: true
end
