require 'rails_helper'

describe 'Admin searches for an order' do
  it 'from home screen' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    # Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'and find an order' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
    service_order = ServiceOrder.create!(shipping_company: shipping_company, vehicle: vehicle, product_model: product_model,
                          estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    fill_in 'Buscar Pedido', with: service_order.code
    click_on 'Buscar'
    # Assert
    expect(page).to have_content "Resultados da Busca por: #{service_order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{service_order.code}"
    expect(page).to have_content 'Transportadora: Alternativa Express LTDA'
    expect(page).to have_content 'Veículo: Sprinter Chassi'
    expect(page).to have_content 'Produto: IMPRESHP9563625'
  end
end