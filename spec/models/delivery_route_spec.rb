require 'rails_helper'

RSpec.describe DeliveryRoute, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when current address is empty' do
        # Arrange
        delivery_route = DeliveryRoute.new(current_address: '', 
                                                exit_address: 'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360', 
                                                current_date: '2022-06-30')
        # Act
        result = delivery_route.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when exit address is empty' do
        # Arrange
        delivery_route = DeliveryRoute.new(current_address: 'Avenida JK, 309 - São Paulo - SP - CEP: 12100-100', 
                                                exit_address: '', 
                                                current_date: '2022-06-30')
        # Act
        result = delivery_route.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when current date is empty' do
        # Arrange
        delivery_route = DeliveryRoute.new(current_address: 'Avenida JK, 309 - São Paulo - SP - CEP: 12100-100', 
                                              exit_address: 'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360', 
                                              current_date: '')
        # Act
        result = delivery_route.valid?
        # Assert
        expect(result).to eq false 
      end
    end
  end
end
