require 'rails_helper'

describe 'Functionary see the orders' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                email: 'transporte@solution.com', cnpj: '55385612000163', 
                                                address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: '362514', 
                                                shipping_company: shipping_company)
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
    service_order = ServiceOrder.create!(shipping_company: shipping_company, vehicle: vehicle, product_model: product_model,
                                                estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(functionary, :scope => :functionary)
    visit root_path
    click_on 'Pedidos'
    click_on service_order.code
    # Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content service_order.code
    expect(page).to have_content 'Transportadora: Solution LTDA'
    expect(page).to have_content 'Veículo: Sprinter Chassi'
  end
end