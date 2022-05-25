require 'rails_helper'

RSpec.describe Functionary, type: :model do
  describe '#valid?' do
    it 'false when email domain is different' do
      # Arrange
      shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
      functionary = Functionary.new(email: 'juliana@gmail.com', password: 'password', shipping_company: shipping_company)
      # Act
      result = functionary.valid?
      # Assert
      expect(result).to eq false
    end
  end
end
