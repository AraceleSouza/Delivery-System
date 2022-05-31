require 'rails_helper'

describe 'Admin sees details of a shipping company' do
  it 'and see additional information' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625', status: 'active' )
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Solution'
    # Assert
    expect(page).to have_content 'Razão Social: Solution LTDA'
    expect(page).to have_content 'Nome Fantasia: Solution'
    expect(page).to have_content 'E-mail: transporte@solution.com'
    expect(page).to have_content 'CNPJ: 55385612000163'
    expect(page).to have_content 'Endereço: Travessa Leopoldino Tantú, 138'  
    expect(page).to have_content 'Cidade: Salvador'
    expect(page).to have_content 'Estado: BA'
    expect(page).to have_content 'CEP: 41180-625' 
    expect(page).to have_content 'Situação Atual: Ativo'
  end

  it 'and back to home screen' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    
    ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                        email: 'transporte@solution.com', cnpj: '55385612000163', 
                        address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                        state:'BA' , cep: '41180-625' )      
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Solution'
    click_on 'Voltar'
    #Assert
    expect(current_path).to eq(shipping_companies_path)
  end

  it 'and disables shipping company' do
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    
    ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                        email: 'transporte@solution.com', cnpj: '55385612000163', 
                        address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                        state:'BA' , cep: '41180-625' )      
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Solution'
    click_on 'Desativar'
    # Assert
    expect(page).to have_content 'Transportadora desativada com sucesso!'
    expect(page).to have_content 'Razão Social: Solution LTDA'
    expect(page).to have_content 'Nome Fantasia: Solution'
    expect(page).to have_content 'E-mail: transporte@solution.com'
    expect(page).to have_content 'CNPJ: 55385612000163'
    expect(page).to have_content 'Endereço: Travessa Leopoldino Tantú, 138'  
    expect(page).to have_content 'Cidade: Salvador'
    expect(page).to have_content 'Estado: BA'
    expect(page).to have_content 'CEP: 41180-625' 
    expect(page).to have_content 'Situação Atual: Inativo'
    expect(page).not_to have_content 'Situação Atual: Ativo'
  end

  it 'and active shipping company' do
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    
    ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                        email: 'transporte@solution.com', cnpj: '55385612000163', 
                        address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                        state:'BA' , cep: '41180-625' )      
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Solution'
    click_on 'Ativar'
    # Assert
    expect(page).to have_content 'Transportadora ativada com sucesso!'
    expect(page).to have_content 'Razão Social: Solution LTDA'
    expect(page).to have_content 'Nome Fantasia: Solution'
    expect(page).to have_content 'E-mail: transporte@solution.com'
    expect(page).to have_content 'CNPJ: 55385612000163'
    expect(page).to have_content 'Endereço: Travessa Leopoldino Tantú, 138'  
    expect(page).to have_content 'Cidade: Salvador'
    expect(page).to have_content 'Estado: BA'
    expect(page).to have_content 'CEP: 41180-625' 
    expect(page).not_to have_content 'Situação Atual: Inativo'
  end
end