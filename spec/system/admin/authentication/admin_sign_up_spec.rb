require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange
    # Act
    visit root_path
    click_on 'Área Admin'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'mariana@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'mariana@email.com'
    expect(page).to have_button 'Sair'
  end
end