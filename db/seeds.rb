admin = Admin.create!(email: 'aracele@email.com', password: '124578')

first_shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', state:'BA' , cep: '41180-625' )
second_shipping_company = ShippingCompany.create!(corporate_name: 'Transportadora Imperial do Brasil LTDA', fantasy_name: 'Transportadora Imperial', 
                                              email: 'contato@transportadoraimperial.com', cnpj: '62325611000167', 
                                              address:'Av das Flores, 108', city: 'Cajamar', state:'SP' , cep: '12536-100' )
third_shipping_company = ShippingCompany.create!(corporate_name: 'Alternativa Express LTDA', fantasy_name: 'Alternativa Express', 
                                              email: 'agendamento@alternativa.com ', cnpj: '43835515000114', 
                                              address:'Rua Conde do Pinhal, 56', city: 'Guarulhos', state:'SP', cep:'12369-122' ) 

functionary = Functionary.create!(email: 'juliana@solution.com', password: '362514', 
                                    shipping_company: shipping_company)
functionary = Functionary.create!(email: 'mariana@solution.com', password: '369258', 
                                    shipping_company: shipping_company)
                                    
Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',model: 'Ducato',freight: '3750', shipping_company: shipping_company)
Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)

                                          
