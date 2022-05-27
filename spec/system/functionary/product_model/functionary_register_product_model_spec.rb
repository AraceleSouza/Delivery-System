require 'rails_helper'

describe 'User registers a product model' do 
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'Notebook Dell'
    fill_in 'Altura', with: '25'
    fill_in 'Largura', with: '35'
    fill_in 'Peso', with: '1700'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'NOTEDELL0905697'
    select 'Transportadora Imperial', from: 'Transportadora'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'Notebook Dell'
    expect(page).to have_content 'Transportadora: Transportadora Imperial'
    expect(page).to have_content 'SKU: NOTEDELL0905697'
    expect(page).to have_content 'Dimensão: 25cm x 35cm x 10cm'
    expect(page).to have_content 'Peso: 1700g'
  end

  it 'must fill in all fields' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Peso', with: ''
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'
  end
end