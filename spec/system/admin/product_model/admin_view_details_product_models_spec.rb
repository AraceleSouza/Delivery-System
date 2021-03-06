require 'rails_helper'

describe 'Admin sees product model details' do
  it 'successfully' do
    # Arrange
    admin = Admin.create!(email: 'aracele@email.com', password: 'password')
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                              email: 'transporte@solution.com', cnpj: '55385612000163', 
                                              address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                              state:'BA' , cep: '41180-625' )
    ProductModel.create!(name: 'Notebook Dell' , weight: 1700 , width: 35 , height: 25 , 
                         depth: 10 , sku: 'NOTEDELL0905697' , shipping_company: shipping_company)
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Solution'
    click_on 'Produtos'
    click_on 'NOTEDELL0905697'

    # Assert
    expect(page).to have_content 'Nome: Notebook Dell'
    expect(page).to have_content 'Peso: 1700'
    expect(page).to have_content 'Largura: 35'
    expect(page).to have_content 'Altura: 25'
    expect(page).to have_content 'Profundidade: 10'  
    expect(page).to have_content 'Código: NOTEDELL0905697'  
  end 
end 