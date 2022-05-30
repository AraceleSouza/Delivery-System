class ShippingCompany < ApplicationRecord
    before_validation :save_email_domain

    has_many :vehicles
    has_many :functionaries  
  


    validates :corporate_name, :fantasy_name, :email, :cnpj , :address, :city, :state, :cep, presence: true
    validates :cnpj, uniqueness: true
    validates :cnpj, length: { is: 14 }

    def save_email_domain
      self.email_domain = self.email.split("@")[1]
    end
end

