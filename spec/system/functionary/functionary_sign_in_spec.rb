require 'rails_helper'

describe 'Functionary manages your account' do
  it 'and log in' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                          email: 'agendamento@alternativa.com', cnpj: '43835515000114', 
                          address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )

    functionary = Functionary.create!(email: 'juliana@alternativa.com', password: 'password', shipping_company: shipping_company)
    # Act
    visit root_path
    click_on 'Área do Funcionário'
    fill_in 'E-mail', with: 'juliana@alternativa.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end 
    # Assert
    expect(page).to have_content "Login efetuado com sucesso."
    expect(page).to have_button 'Sair'
    expect(page).to have_link 'Minha Transportadora'
    expect(page).not_to have_link 'Entrar'
    expect(page).not_to have_link 'Área do Funcionário'
    within('nav') do
      expect(page).to have_content "Olá juliana@alternativa.com"
    end

    
  end

  it 'and logout' do 
  # Arrange
  shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                          email: 'agendamento@alternativa.com', cnpj: '43835515000114', 
                          address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )

  Functionary.create!(email: 'juliana@alternativa.com', password: 'password', shipping_company: shipping_company)
  # Act
  visit root_path
  click_on 'Área do Funcionário'
  fill_in 'E-mail', with: 'juliana@alternativa.com'
  fill_in 'Senha', with: 'password'
  within('form') do
    click_on 'Entrar'
  end
  click_on 'Sair'
    # Assert
  expect(page).to have_content 'Logout efetuado com sucesso.'
  expect(page).to have_link 'Área do Funcionário'
  expect(page).not_to have_button 'Sair'
  
  end
end