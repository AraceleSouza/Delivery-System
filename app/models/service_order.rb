class ServiceOrder < ApplicationRecord
  belongs_to :shipping_company
  belongs_to :vehicle
  belongs_to :product_model
  enum status: {pending: 0, delivered: 5, canceled: 9 }

  validates :code, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
