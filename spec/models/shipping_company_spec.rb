require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: ' ', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when fantasy_name is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: ' ', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when email is empty' do
          # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: ' ', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when cnpj is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: ' ', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when address is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:' ', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when city is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: ' ', 
                                                state:'BA' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when state is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:' ' , cep: '41180-625' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when cep is empty' do
        # Arrange
        shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: ' ' )
        # Act
        result = shipping_company.valid?
        # Assert
        expect(result).to eq false 
        end
      end 

    it 'false when cnpj is already in use' do
      # Arrange
      first_shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                       email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                       address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                       state:'BA' , cep: '41180-625' )

      second_shipping_company = ShippingCompany.new(corporate_name: 'Transportadora Imperial do Brasil LTDA', fantasy_name: 'Transportadora Imperial', 
                                                    email: 'contato@transportadoraimperial.com', cnpj: '55385612000163', 
                                                    address:'Av das Flores, 108', city: 'Cajamar', state:'SP' , cep: '12536-100' )                                        
      # Act
      result = second_shipping_company.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when cnpj is invalid' do
      # Arrange
      shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                       email: 'transporte@solution.com.br', cnpj: '55385612', 
                                                       address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                       state:'BA' , cep: '41180-625' )
      # Act
      result = shipping_company.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when cep is invalid' do
      # Arrange
      shipping_company = ShippingCompany.new(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                       email: 'transporte@solution.com.br', cnpj: '55385612000163', 
                                                       address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                       state:'BA' , cep: '411651' )
      # Act
      result = shipping_company.valid?
      # Assert
      expect(result).to eq false
    end
  end
end
