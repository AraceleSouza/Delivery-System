require 'rails_helper'

describe 'Admin manages your account' do
  it 'and log in' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    click_on 'Área Admin'
    fill_in 'E-mail', with: 'aracele@email.com'
    fill_in 'Senha', with: 'password'
      within('form') do
    click_on 'Entrar'
    end 
    # Assert
    expect(page).to have_content "Login efetuado com sucesso."
    expect(page).to have_button 'Sair' 
    expect(page).not_to have_link 'Entrar'
    expect(page).not_to have_link 'Minha Transportadora'
    expect(page).not_to have_link 'Área do Funcionário'
    within('nav') do
      expect(page).to have_content "Olá aracele@email.com"
    end
  end

  it 'and logout' do 
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    login(admin)
    click_on 'Sair'
      # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Área Admin'
    expect(page).not_to have_button 'Sair'
  end
end