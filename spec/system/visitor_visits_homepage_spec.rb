require 'rails_helper'

describe 'visitor visits home page' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).to have_content 'Sistema de Entregas'
  end

  it 'and search for order' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ALTERN123456789') 
    service_order = ServiceOrder.create!(shipping_company: shipping_company, vehicle: vehicle, 
                                        product_model: product_model, estimated_delivery_date: 1.day.from_now)
    # Act
    visit root_path
    fill_in 'Buscar Pedido', with: 'ALTERN'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content 'ALTERN123456789'
    expect(page).to have_content 'Transportadora: Alternativa Express LTDA'
  end

  it 'to see tracking' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ALTERN123456789') 
    service_order = ServiceOrder.create!(shipping_company: shipping_company, vehicle: vehicle, 
                                        product_model: product_model, estimated_delivery_date: 1.day.from_now)
    delivery_route = DeliveryRoute.create!(current_address: 'Avenida JK, 309 - São Paulo - SP - CEP: 12100-100', 
                                          exit_address: 'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360', 
                                          current_date: '2022-06-30', service_order: service_order)
    # Act
    visit root_path
    fill_in 'Buscar Pedido', with: 'ALTERN'
    click_on 'Buscar'
    click_on service_order.code
    # Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content 'RASTREAMENTO'
    expect(page).to have_content 'Objeto em trânsito - por favor aguarde'
    expect(page).to have_content 'Endereço atual: Avenida JK, 309 - São Paulo - SP - CEP: 12100-100'
    expect(page).to have_content 'Endereço de saída: Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360'
    expect(page).to have_content 'Data: 2022-06-30'
  end
end