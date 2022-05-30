require 'rails_helper'

describe 'Functionary sees vehicles' do
  it 'if you are authenticated' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                              email: 'transporte@solution.com', cnpj: '55385612000163', 
                                              address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                              state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', shipping_company: shipping_company)
    Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',model: 'Ducato',freight: '3750', shipping_company: shipping_company)
    # Act
    visit root_path
    click_on 'Área do Funcionário'
    fill_in 'E-mail', with: 'juliana@solution.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    
    # Assert
    expect(page).to have_content "Login efetuado com sucesso."
    expect(page).to have_button 'Sair'
    expect(page).to have_link 'Minha Transportadora'
    expect(page).not_to have_link 'Entrar'
    expect(page).not_to have_link 'Área do Funcionário'
    within('nav') do
      expect(page).to have_content "Olá juliana@solution.com"
    end
  end

  it 'successfully' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                              email: 'transporte@solution.com', cnpj: '55385612000163', 
                                              address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                              state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                      shipping_company: shipping_company)
    Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',model: 'Ducato',freight: '3750', shipping_company: shipping_company)
    Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Veículos'
    # Assert
    expect(page).to have_link 'Ducato'
    expect(page).to have_link 'Sprinter Chassi' 
  end

  it 'and view vehicle details' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                              email: 'transporte@solution.com', cnpj: '55385612000163', 
                                              address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                              state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                      shipping_company: shipping_company)
    Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',model: 'Ducato',
                    freight: '3750', shipping_company: shipping_company)
    Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',model: 'Sprinter Chassi',
                    freight: '1.840', shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Veículos'
    click_on 'Ducato'

    # Assert
    expect(page).to have_content 'Modelo: Ducato'
    expect(page).to have_content 'Marca: Fiat'
    expect(page).to have_content 'Placa: HMG-0248'
    expect(page).to have_content 'Ano de Fabricação: 2021'
    expect(page).to have_content 'Capacidade Máxima: 3750 kg'  
    
    expect(page).not_to have_content 'Modelo: Sprinter Chassi '
    expect(page).not_to have_content 'Marca: Mercedes-Benz'
    expect(page).not_to have_content 'Placa: JSQ-7436'
    expect(page).not_to have_content 'Ano de Fabricação: 2019'
    expect(page).not_to have_content 'Capacidade Máxima: 1840 kg'  
  end 

  it 'and there are no registered vehicles' do
    # Arrange 
    shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                    shipping_company: shipping_company)
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Veículos'
    # Arrange 
    expect(page).to have_content('Não existem veículos cadastrados.')
  end

  it 'only from your shipping_company' do
    # Arrange
    first_shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                                      email: 'transporte@solution.com', cnpj: '55385612000163', 
                                                      address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                                      state:'BA' , cep: '41180-625' )

    second_shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', 
                                                      fantasy_name: 'Transportadora Imperial',
                                                      email: 'contato@transportadoraimperial.com', 
                                                      cnpj: '62325611000167', address:'Av das Flores, 108', 
                                                      city: 'Cajamar', state:'SP' , cep: '12536-100' )

    functionary = Functionary.create!(email: 'juliana@solution.com', password: 'password', 
                                      shipping_company: first_shipping_company )

    Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',
                                    model: 'Ducato', freight: '3750', shipping_company: first_shipping_company)
    Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',
                                    model: 'Sprinter Chassi', freight: '1.840', 
                                    shipping_company: second_shipping_company )
    Vehicle.create!(plate: 'JDR-0312', brand: 'Ford', year_fabrication: '2006',
                                    model: 'Cargo 2422', freight: '23000', 
                                    shipping_company: first_shipping_company )
    # Act
    login_as(functionary)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Veículos'
    # Assert
    expect(page).to have_content 'Modelo: Ducato'
    expect(page).to have_content 'Modelo: Cargo 2422'
    expect(page).not_to have_content 'Modelo: Sprinter Chassi'
  end
end