require 'rails_helper' 

describe 'Functionary sees shipping company deadline' do
  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                               fantasy_name: 'Transportadora Imperial', 
                                               email: 'contato@transportadoraimperial.com', 
                                               cnpj: '62325611000167', address:'Av das Flores, 108', 
                                               city: 'Cajamar', state:'SP' , cep: '12536-100' )
    functionary = Functionary.create!(email: 'eduarda@transportadoraimperial.com', password: 'password', 
                                      shipping_company: shipping_company)
    Deadline.create!(min_distance: 10, max_distance: 100, deadline_in_days: 2 , shipping_company: shipping_company)         
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Prazos de Entrega'
    # Assert
    expect(current_path).to eq shipping_company_deadlines_path(shipping_company.id)
    expect(page).to have_content 'Distância Mínima: 10 metros'
    expect(page).to have_content 'Distância Máxima: 100 metros'
    expect(page).to have_content 'Prazo em Dias: 2 dias úteis'    
  end
end