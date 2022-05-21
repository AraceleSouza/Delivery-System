class ShippingCompany < ApplicationRecord
    validates :corporate_name, :fantasy_name, :email, :cnpj , :address, :city, :state, :cep, presence: true
    validates :cnpj, uniqueness: true
    validates :cnpj, length: { is: 14 }
    validates :cep, length: { is: 9 }
    validates :cep, format: { with: /\A\d{5}-\d{3}\z/ }
end
