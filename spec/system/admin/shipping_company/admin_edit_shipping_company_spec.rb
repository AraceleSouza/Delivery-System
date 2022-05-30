require 'rails_helper'

describe 'User edits a shipping company' do 
  it 'from the details page' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password') 

    ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Alternativa Express'
    click_on 'Editar'
    # Assert
    expect(page).to have_field('Razão Social', with: 'Alternativa Express LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'Alternativa Express')
    expect(page).to have_field('CNPJ', with: '43835515000114')
    expect(page).to have_field('Endereço', with: 'Rua Conde do Pinhal, 56')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('CEP', with: '12369-122')
  end

  it 'successfully' do 
    # Arrange 
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')  
    ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Alternativa Express'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Alternativa Express'
    fill_in 'CNPJ', with: '43835515000114'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Transportadora atualizada com sucesso.'
    expect(page).to have_content 'Transportadora: Alternativa Express'
    expect(page).to have_content 'CNPJ: 43835515000114'
  end

  it 'and keep the required fields' do 
    # Arrange 
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')  
    ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                            email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                            address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Alternativa Express'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Não foi possível atualizar a transportadora.'  
  end
end