require 'rails_helper'

describe 'Admin sees list of shipping company' do
  it 'if you are authenticated' do
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

  it 'successfully' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    
    ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', fantasy_name: 'Transportadora Imperial', 
                            email: 'contato@transportadoraimperial.com', cnpj: '62325611000167', 
                            address:'Av das Flores, 108', city: 'Cajamar', state:'SP' , cep: '12536-100' )
    ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )    
    # Act
    visit root_path
    login(admin)
    click_on 'Transportadoras'
    # Assert
    expect(page).to have_content('Transportadoras')
    expect(page).to have_content('Transportadora: Transportadora Imperial')
    expect(page).to have_content('CNPJ: 62325611000167')
    
    expect(page).to have_content('Transportadora: Alternativa Express')
    expect(page).to have_content('CNPJ: 43835515000114')
  end
 
  it 'and there are no registered shipping company' do
    # Arrange 
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    login(admin)
    click_on 'Transportadoras'
    # Arrange 
    expect(page).to have_content('Não existem transportadoras cadastradas.')
  end
end