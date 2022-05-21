require 'rails_helper'

describe 'Functionary authenticates' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Área do Funcionário'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'juliana@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'juliana@email.com'
    expect(page).to have_button 'Sair'
  end
end