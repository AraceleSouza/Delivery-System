require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe 'generate a randow code' do
    it 'when creating a new order ' do
      # Arrange
      admin = Admin.create!(email: 'aracele@email.com', password: 'password')
      shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                              email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                              address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
      vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                                model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
      product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                          sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
      service_order = ServiceOrder.new(shipping_company: shipping_company, vehicle: vehicle, product_model:product_model, 
                                          full_address:'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360', 
                                          customer_address:'Avenida do Museu do Amanhã, 1000 - Rio de Janeiro - RJ - CEP: 20100-000', 
                                          customer_name:'Mariana da Silva', estimated_delivery_date:'05/10/2022')
      # Act
      service_order.save!
      result = service_order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 15
    end

    it 'and the code is unique' do
      # Arrange
      admin = Admin.create!(email: 'aracele@email.com', password: 'password')
      shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                              email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                              address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
      vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                                model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
      product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                          sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
      first_service_order = ServiceOrder.create!(shipping_company: shipping_company, vehicle: vehicle, product_model:product_model, 
                                                full_address:'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360', 
                                                customer_address:'Avenida do Museu do Amanhã, 1000 - Rio de Janeiro - RJ - CEP: 20100-000', 
                                                customer_name:'Mariana da Silva', estimated_delivery_date:'05/10/2022')
      second_service_order = ServiceOrder.new(shipping_company: shipping_company, vehicle: vehicle, product_model:product_model, 
                                              full_address:'Rua 9 de Setembro, 148 - São Paulo - SP - CEP: 12255-366', 
                                              customer_address:'Rua São Francisco Xavier, 245 - Rio de Janeiro - RJ - CEP: 23530-812', 
                                              customer_name:'Pedro dos Santos', estimated_delivery_date:'15/09/2022')
      # Act
      second_service_order.save!
      # Assert
      expect(second_service_order.code).not_to eq first_service_order.code
    end
  end
end
