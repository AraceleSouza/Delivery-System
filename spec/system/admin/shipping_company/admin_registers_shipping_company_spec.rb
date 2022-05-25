require 'rails_helper'

describe 'Admin registers a shipping company' do
  it 'from home screen' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    login(admin)
    click_on 'Transportadoras'
    click_on 'Cadastrar Transportadora'
      # Assert
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('CEP')
  end

  it 'successfully' do 
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    login(admin)
    click_on 'Transportadoras'
    click_on 'Cadastrar Transportadora'
    fill_in 'Razão Social', with: 'Super Cargas Express LTDA'
    fill_in 'Nome Fantasia', with:  'Super Cargas'
    fill_in 'CNPJ', with: '12385531000142'
    fill_in 'E-mail', with: 'transporte@supercargas.com'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '20100-000'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq shipping_companies_path
    expect(page).to have_content 'Transportadora cadastrada com sucesso.'
    expect(page).to have_content 'Transportadora: Super Cargas'
    expect(page).to have_content 'CNPJ: 12385531000142'    
  end

  it 'with incomplete data' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    login(admin)
    click_on 'Transportadoras'
    click_on 'Cadastrar Transportadora'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content "Transportadora não cadastrada."
    expect(page).to have_content "Razão Social não pode ficar em branco" 
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
    expect(page).to have_content "E-mail não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
  end
end