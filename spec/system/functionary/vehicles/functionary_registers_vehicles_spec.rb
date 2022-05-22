require 'rails_helper'

describe 'Functionary registers a vehicle' do
  it 'from home screen' do
  # Arrange
  shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
  functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                    shipping_company: shipping_company)
  # Act
  login_as(functionary)
  visit root_path
  click_on 'Minha Transportadora'
  click_on 'Veículos'
  click_on 'Cadastrar Veículo'

  # Assert
  expect(page).to have_field('Modelo')
  expect(page).to have_field('Marca')
  expect(page).to have_field('Placa')
  expect(page).to have_field('Ano de Fabricação')
  expect(page).to have_field('Capacidade Máxima')
  
  end

  it 'successfully' do 
  # Arrange
  shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
  functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                    shipping_company: shipping_company)
  # Act
  login_as(functionary)
  visit new_shipping_company_vehicle_path(shipping_company.id)
  fill_in 'Modelo', with: 'Sprinter Chassi'
  fill_in 'Marca', with:  'Mercedes-Benz'
  fill_in 'Placa', with: 'JSQ-7436'
  fill_in 'Ano de Fabricação', with: '2019'
  fill_in 'Capacidade Máxima', with: '1840'
  click_on 'Enviar'

    # Assert
    expect(current_path).to eq shipping_company_vehicles_path(shipping_company.id)
    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Modelo: Sprinter Chassi'
  end

  it 'with incomplete data' do
  shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
  functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                    shipping_company: shipping_company)
  # Act
  login_as(functionary)
  visit new_shipping_company_vehicle_path(shipping_company.id)
  fill_in 'Modelo', with: ' '
  fill_in 'Marca', with:  ' '
  fill_in 'Placa', with: ' '
  fill_in 'Ano de Fabricação', with: ' '
  fill_in 'Capacidade Máxima', with: ' '
  click_on 'Enviar'

  # Assert
  expect(page).to have_content "Veículo não cadastrado."
  expect(page).to have_content "Modelo não pode ficar em branco" 
  expect(page).to have_content "Marca não pode ficar em branco"
  expect(page).to have_content "Placa não pode ficar em branco"
  expect(page).to have_content "Ano de Fabricação não pode ficar em branco"
  expect(page).to have_content "Capacidade Máxima não pode ficar em branco"
  
  end
end