require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: ' ' , weight: 1700 , width: 35 , height: 25 , 
                                              depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when sku is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: 'Notebook Dell' , weight: 1700 , width: 35 , height: 25 , 
                                              depth: 10 , sku: ' ' , shipping_company: shipping_company)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end
    end 
  end 
end
