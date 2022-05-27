require 'rails_helper' 

describe 'Functionary registers shipping company deadlines' do
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
    visit shipping_company_deadlines_path(shipping_company.id)
    click_on 'Cadastrar Prazo' 
    fill_in 'Distância Mínima', with: '10.00 metros'
    fill_in 'Distância Máxima', with: '100.00 metros'
    fill_in 'Prazo em Dias', with: '2 dias úteis'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq shipping_company_deadlines_path(shipping_company.id)
    expect(page).to have_content 'Prazo cadastrado com sucesso.'
    expect(page).to have_content 'Distância Mínima: 10 metros'
    expect(page).to have_content 'Distância Máxima: 100 metros'
    expect(page).to have_content 'Prazo em Dias: 2 dias úteis'                               
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
    visit shipping_company_deadlines_path(shipping_company.id)
    click_on 'Cadastrar Prazo' 
    fill_in 'Distância Mínima', with: ' '
    fill_in 'Distância Máxima', with: ' '
    fill_in 'Prazo em Dias', with: ' '
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq shipping_company_deadlines_path(shipping_company.id)
    expect(page).to have_content 'Prazo não cadastrado.'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Prazo em Dias não pode ficar em branco'  
  end
end