require 'rails_helper'

describe 'Admin sees list of carriers' do
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
  expect(page).to have_content('Localização: Cajamar - SP')
   
  expect(page).to have_content('Transportadora: Alternativa Express')
  expect(page).to have_content('CNPJ: 43835515000114')
  expect(page).to have_content('Localização: Guarulhos - SP')

  end
 
  it 'and there are no registered carriers' do
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