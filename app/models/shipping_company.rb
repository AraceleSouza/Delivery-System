class ShippingCompany < ApplicationRecord
    before_validation :save_email_domain
    enum status: { active: 0, inactive: 5 }
    
    has_many :vehicles
    has_many :functionaries
    has_many :price_settings
    has_many :product_models
    has_many :service_orders
     

    validates :corporate_name, :fantasy_name, :email, :cnpj , :address, :city, :state, :cep, presence: true
    validates :cnpj, uniqueness: true
    validates :cnpj, length: { is: 14 }

    def save_email_domain
      self.email_domain = self.email.split("@")[1]
    end
end

