require 'rails_helper' 

describe 'Functionary sees shipping company price list' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                               fantasy_name: 'Transportadora Imperial', 
                                               email: 'contato@transportadoraimperial.com', 
                                               cnpj: '62325611000167', address:'Av das Flores, 108', 
                                               city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    
    PriceSetting.create!(min_weight: 0.10, 
                  max_weight: 0.50,
                  min_cubic_meter: 1,
                  max_cubic_meter: 2,
                  distance_value: 180, shipping_company: shipping_company)
                  
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços'
    # Assert
    expect(current_path).to eq shipping_company_price_settings_path(shipping_company.id)
    expect(page).to have_content 'Peso Mínimo: 0,10'
    expect(page).to have_content 'Peso Máximo: 0,50'
    expect(page).to have_content 'Metros cubicos Máximo: 2 metros'
    expect(page).to have_content 'Metros cubicos Mínimo: 1 metro'
    expect(page).to have_content 'Valor por KM: R$ 180,00'    
  end
end