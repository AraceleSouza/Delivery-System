admin = Admin.create!(email: 'aracele@email.com', password: '124578')
shipping_company = ShippingCompany.create!(corporate_name: 'Solution LTDA', fantasy_name: 'Solution', 
                                            email: 'transporte@solution.com', cnpj: '55385612000163', 
                                            address:'Travessa Leopoldino Tantú, 138', city: 'Salvador', 
                                            state:'BA' , cep: '41180-625' )
functionary = Functionary.create!(email: 'juliana@solution.com', password: '362514', 
                                    shipping_company: shipping_company)
                                    
Vehicle.create!(plate: 'HMG-0248', brand: 'Fiat', year_fabrication: '2021',model: 'Ducato',freight: '3750', shipping_company: shipping_company)
Vehicle.create!(plate: 'JSQ-7436', brand: 'Mercedes-Benz', year_fabrication: '2019',model: 'Sprinter Chassi',freight: '1.840', shipping_company: shipping_company)

                                          
