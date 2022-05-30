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
    expect(page).to have_content('1 pedido encontrado')
    expect(page).to have_content('ALTERN123456789')
    expect(page).to have_content 'Transportadora: Alternativa Express LTDA'
  end
end