require 'rails_helper' 

describe 'Functionary registers shipping company prices' do
  it 'successfully' do
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
    visit shipping_company_price_settings_path(shipping_company.id)
    click_on 'Cadastrar Preço' 
    fill_in 'Peso Mínimo', with: '0.15'
    fill_in 'Peso Máximo', with: '0.60'
    fill_in 'Metros cubicos Mínimo', with: '1 metro'
    fill_in 'Metros cubicos Máximo', with: '2.5 metros'
    fill_in 'Valor por KM', with: '190'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq shipping_company_price_settings_path(shipping_company.id)
    expect(page).to have_content 'Preço cadastrado com sucesso.'
    expect(page).to have_content 'Peso Mínimo: 0,15'
    expect(page).to have_content 'Peso Máximo: 0,60'
    expect(page).to have_content 'Metros cubicos Mínimo: 1 metro'
    expect(page).to have_content 'Metros cubicos Máximo: 2,5 metros'
    expect(page).to have_content 'Valor por KM: R$ 190,00'                               
  end

  
  it 'with incomplete data' do 
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
    visit shipping_company_price_settings_path(shipping_company.id)
    click_on 'Cadastrar Preço' 
    fill_in 'Peso Mínimo', with: ' '
    fill_in 'Peso Máximo', with: ' '
    fill_in 'Metros cubicos Mínimo', with: ' '
    fill_in 'Metros cubicos Máximo', with: ' '
    fill_in 'Valor por KM', with: ''
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq shipping_company_price_settings_path(shipping_company.id)
    expect(page).to have_content 'Preço não cadastrado.'
    expect(page).to have_content "Peso Mínimo não pode ficar em branco" 
    expect(page).to have_content "Peso Máximo não pode ficar em branco"
    expect(page).to have_content "Metros cubicos Mínimo não pode ficar em branco"
    expect(page).to have_content "Metros cubicos Máximo não pode ficar em branco"
    expect(page).to have_content "Valor por KM não pode ficar em branco"
  end
end