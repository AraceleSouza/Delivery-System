require 'rails_helper'

describe 'Admin register an order' do
  it 'successfully' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')

    ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', fantasy_name: 'Transportadora Imperial', 
                            email: 'contato@transportadoraimperial.com', cnpj: '62325611000167', 
                            address:'Av das Flores, 108', city: 'Cajamar', state:'SP' , cep: '12536-100' )
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  

    Vehicle.create(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',
                  model: 'Ducato',freight: '3750', shipping_company: shipping_company)
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
                              
    ProductModel.create(name: 'Notebook Dell' , weight: 1700 , width: 35 , height: 25 , depth: 10 , 
                        sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)    
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCDEF123456789') 
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Registrar Pedido'
    select shipping_company.corporate_name, from: 'Transportadora'
    select vehicle.model, from: 'Veículo'
    select product_model.sku, from: 'Produto'
    fill_in 'Endereço para retirada', with: 'Rua das Flores, 100 - São Paulo - SP - CEP: 12255-360'
    fill_in 'Endereço do cliente', with: 'Avenida do Museu do Amanhã, 1000 - Rio de Janeiro - RJ - CEP: 20100-000'
    fill_in 'Nome do cliente', with: 'Mariana da Silva'
    fill_in 'Data prevista para entrega', with: '05/10/2022'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido: ABCDEF123456789'
    expect(page).to have_content 'Transportadora: Alternativa Express LTDA'
    expect(page).to have_content 'Veículo: Sprinter Chassi'
    expect(page).to have_content 'Produto: IMPRESHP9563625'
    expect(page).to have_content 'Data prevista para entrega: 05/10/2022'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).not_to have_content 'Transportadora Imperial do Brasil LTDA'
    expect(page).not_to have_content 'Ducato'
    expect(page).not_to have_content 'Notebook Dell'
  end

  it 'and does not inform the delivery date' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )  
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company:shipping_company)    
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Registrar Pedido'
    select shipping_company.corporate_name, from: 'Transportadora'
    select vehicle.model, from: 'Veículo'
    select product_model.sku, from: 'Produto'
    fill_in 'Data prevista para entrega', with: ' '
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Não foi possível registrar o pedido.'
    expect(page).to have_content 'Data prevista para entrega não pode ficar em branco'
  end

  it 'and find multiple orders' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    first_shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114',
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    second_shipping_company = ShippingCompany.create(corporate_name: 'Transportadora Imperial do Brasil LTDA', fantasy_name: 'Transportadora Imperial', 
                                email: 'contato@transportadoraimperial.com', cnpj: '62325611000167', 
                                address:'Av das Flores, 108', city: 'Cajamar', state:'SP' , cep: '12536-100' )
    vehicle = Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                              model: 'Sprinter Chassi',freight: '1.840', shipping_company: first_shipping_company)
    product_model = ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , depth: 35,
                                        sku: 'IMPRESHP9563625' , shipping_company: first_shipping_company) 

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ALTERN123456789') 
    first_service_order = ServiceOrder.create!(shipping_company: first_shipping_company, vehicle: vehicle, 
                                                product_model: product_model, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ALTERN123451425') 
    second_service_order = ServiceOrder.create!(shipping_company: first_shipping_company, vehicle: vehicle, 
                                                product_model: product_model, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('TRANSP123456789')
    third_service_order = ServiceOrder.create!(shipping_company: second_shipping_company, vehicle: vehicle, 
                                                product_model: product_model, estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    fill_in 'Buscar Pedido', with: 'ALTERN'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('ALTERN123456789')
    expect(page).to have_content('ALTERN123451425') 
    expect(page).to have_content 'Transportadora: Alternativa Express LTDA'
    expect(page).not_to have_content ('TRANSP123456789')
    expect(page).not_to have_content 'Transportadora: Transportadora Imperial do Brasil LTDA'
  end
end