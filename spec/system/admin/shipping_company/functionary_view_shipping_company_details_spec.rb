require 'rails_helper'

describe 'Functionary sees details of your shipping company' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    # Assert
    expect(page).to have_content 'Nome Fantasia: Solution'
    expect(page).to have_content 'Razão Social: Solution LTDA'
    expect(page).to have_content 'E-mail: transporte@solution.com'
    expect(page).to have_content 'CNPJ: 55385612000163'
    expect(page).to have_content 'Endereço: Travessa Leopoldino Tantú, 138'  
    expect(page).to have_content 'Cidade: Salvador'
    expect(page).to have_content 'Estado: BA'
    expect(page).to have_content 'CEP: 41180-625'
  end
end