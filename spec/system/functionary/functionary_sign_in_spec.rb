require 'rails_helper'

describe 'Functionary manages your account' do
  it 'and log in' do
    # Arrange
    user = Functionary.create!(email: 'juliana@email.com', password: 'password')
    # Act
    visit root_path
    click_on 'Área do Funcionário'
    fill_in 'E-mail', with: 'juliana@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end 
    # Assert
    expect(page).to have_content "Login efetuado com sucesso."
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    within('nav') do
      expect(page).to have_content "Olá juliana@email.com"
    end
  end

  it 'and logout' do 
  # Arrange
  user = Functionary.create!(email: 'juliana@email.com', password: 'password')
  # Act
  visit root_path
  click_on 'Área do Funcionário'
  fill_in 'E-mail', with: 'juliana@email.com'
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