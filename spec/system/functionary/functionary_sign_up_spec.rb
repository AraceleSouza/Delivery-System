require 'rails_helper'

describe 'Functionary authenticates' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                                                email: 'agendamento@alternativa.com', cnpj: '43835515000114', 
                                                address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    # Act
    visit root_path
    click_on 'Área do Funcionário'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'juliana@alternativa.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'juliana@alternativa.com'
    expect(page).to have_button 'Sair'
    expect(shipping_company).to eq Functionary.last.shipping_company
  end

  it 'e não deve cadastrar se o dominio de email não esta presente no sistema' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                                                email: 'agendamento@alternativa.com', cnpj: '43835515000114', 
                                                address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    # Act
    visit root_path
    click_on 'Área do Funcionário'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'juliana@cargas.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    # Assert
    expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).not_to have_content 'juliana@alternativa.com'
    expect(page).to have_content 'Email não cadastrado no sistema.'

  end
end