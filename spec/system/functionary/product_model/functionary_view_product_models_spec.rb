require 'rails_helper'

describe 'Admin sees product models' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    ProductModel.create!(name: 'Notebook Dell' , weight: 1700 , width: 35 , height: 25 , 
                         depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
    ProductModel.create!(name: 'Impressora HP' , weight: 4000 , width: 40 , height: 18 , 
                        depth: 35 , sku: 'IMPRESHP9563625' , shipping_company:shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Modelos de Produtos'
    # Assert
    expect(page).to have_content 'Notebook Dell'
    expect(page).to have_content 'NOTEDELL0905697'
    expect(page).to have_content 'Impressora HP'
    expect(page).to have_content 'IMPRESHP9563625'
  end

  it 'and there are no registered products' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                fantasy_name: 'Transportadora Imperial', 
                                                email: 'contato@transportadoraimperial.com', 
                                                cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Modelos de Produtos'
    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
end