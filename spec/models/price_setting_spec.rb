require 'rails_helper'

RSpec.describe PriceSetting, type: :model do
  describe '#valid?' do
    it 'false when min_weight is less than expected' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                  fantasy_name: 'Transportadora Imperial', 
                                                  email: 'contato@transportadoraimperial.com', 
                                                  cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                  city: 'Cajamar', state:'SP' , cep: '12536-100' )
      functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                        shipping_company: shipping_company)
      price_setting = PriceSetting.new(min_weight: 0.01, max_weight: 0.50, min_cubic_meter: 1, max_cubic_meter: 2,
                                          distance_value: 180, shipping_company: shipping_company) 
      # Act
      result = price_setting.valid?
      # Assert
      expect(result).to eq false
    end 

    it 'false when max_weight is less than expected' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                  fantasy_name: 'Transportadora Imperial', 
                                                  email: 'contato@transportadoraimperial.com', 
                                                  cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                  city: 'Cajamar', state:'SP' , cep: '12536-100' )
      functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                        shipping_company: shipping_company)
      price_setting = PriceSetting.new(min_weight: 0.01, max_weight: 0.10, min_cubic_meter: 1, max_cubic_meter: 2,
                                          distance_value: 180, shipping_company: shipping_company) 
      # Act
      result = price_setting.valid?
      # Assert
      expect(result).to eq false
    end 

    it 'false when min_weight is equal to max_weight' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                  fantasy_name: 'Transportadora Imperial', 
                                                  email: 'contato@transportadoraimperial.com', 
                                                  cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                  city: 'Cajamar', state:'SP' , cep: '12536-100' )
      functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                        shipping_company: shipping_company)
      price_setting = PriceSetting.new(min_weight: 0.60, max_weight: 0.60, min_cubic_meter: 1, max_cubic_meter: 2,
                                          distance_value: 180, shipping_company: shipping_company) 
    
      # Act
      result = price_setting.valid?
      # Assert
      expect(result).to eq false
    end
  end
end 

