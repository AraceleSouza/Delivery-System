require 'rails_helper'

describe 'Admin registers a product model' do 
  it 'successfully' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Transportadora Imperial'
    click_on 'Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'Notebook Dell'
    fill_in 'Altura', with: '25'
    fill_in 'Largura', with: '35'
    fill_in 'Peso', with: '1700'
    fill_in 'Profundidade', with: '10'
    fill_in 'Código', with: 'NOTEDELL0905697'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Produto cadastrado com sucesso.'
    expect(page).to have_content 'Notebook Dell'
    expect(page).to have_content 'Código: NOTEDELL0905697'
  end

  it 'must fill in all fields' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Transportadora Imperial'
    click_on 'Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Peso', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o produto.'
  end
end