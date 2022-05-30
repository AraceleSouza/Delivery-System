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

      it 'false when weight is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: 'Notebook Dell' , width: 35 , height: 25 , 
                                              depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end
      
      it 'false when width is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: 'Notebook Dell' , weight: 1700  , height: 25 , 
                                              depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when height is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: 'Notebook Dell' , weight: 1700 , width: 35 , 
                                              depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when depth is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
        product_model = ProductModel.new(name: 'Notebook Dell' , weight: 1700 , width: 35 , height: 25 , 
                                              sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
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

    it 'false when sku is already in use' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                              email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                              address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', 
                              cep:'12369-122' )
      first_product_model = ProductModel.create!(name: 'Notebook Dell', weight: 1700, width: 35, 
                                              height: 25, depth: 10 , sku: 'NOTEDELL0905697', 
                                              shipping_company: shipping_company)
      second_product_model = ProductModel.new(name: 'Impressora HP', weight: 4000, width: 40, 
                                                  height: 18, depth: 35, sku: 'NOTEDELL0905697', 
                                                  shipping_company: shipping_company)                                       
      # Act
      result = second_product_model.valid?
      # Assert
      expect(result).to eq false
    end
  end 
end
