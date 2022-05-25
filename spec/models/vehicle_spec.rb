require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when plate is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
        vehicle = Vehicle.new(plate:' ', brand: 'Fiat', year_fabrication: '2021',
                                  model: 'Ducato',freight: '3750', shipping_company: shipping_company)
        # Act
        result = vehicle.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when brand is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
        vehicle = Vehicle.new(plate: 'HMG-0248', brand:' ', year_fabrication: '2021',
                                  model: 'Ducato',freight: '3750', shipping_company: shipping_company)
        # Act
        result = vehicle.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when year_fabrication is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
        vehicle = Vehicle.new(plate: 'HMG-0248', brand: 'Fiat', year_fabrication:' ',
                                  model: 'Ducato',freight: '3750', shipping_company: shipping_company)
        # Act
        result = vehicle.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when model is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
        vehicle = Vehicle.new(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',
                                  model:' ',freight: '3750', shipping_company: shipping_company)
        # Act
        result = vehicle.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when freight is empty' do
        # Arrange
        shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
        vehicle = Vehicle.new(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',
                                  model: 'Ducato',freight:' ', shipping_company: shipping_company)
        # Act
        result = vehicle.valid?
        # Assert
        expect(result).to eq false 
      end
    end 

    it 'false when plate is already in use' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
      first_vehicle = Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',
                                    model: 'Ducato',freight:'3.750', shipping_company: shipping_company)

      second_vehicle = Vehicle.new(plate: 'HMG-0248', brand: 'Mercedes-Benz', year_fabrication: '2019',
                                    model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
      # Act
      result = second_vehicle.valid?
      # Assert
      expect(result).to eq false
    end
  end
end
