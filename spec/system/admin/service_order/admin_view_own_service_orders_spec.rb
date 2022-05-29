require 'rails_helper'

describe 'Admin sees their own orders' do
  it 'successfully' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: '123789')
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
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content service_order.code
  end

  it 'and there are no orders registered' do
    # Arrange 
    admin = Admin.create!(email: 'aracele@email.com', password: '123789')
    # Act
    login_as(admin)
    visit root_path
    click_on 'Meus Pedidos'
    # Arrange 
    expect(page).to have_content('Não existem ordens de serviço cadastradas.')
  end
end