# Sistema de Entregas :articulated_lorry:

## Descrição do projeto:


Aplicação responsável por gerenciar meios de transporte disponíveis para e-commerces. Possui várias transportadoras cadastradas, cada uma delas com seus respectivos preços de frete e prazos de entrega. Para acessar as informações do sistema os usuários devem inserir um e-mail e uma senha de acordo com cada tipo de usuário.  Usuários não cadastrados conseguem fazer apenas consultas de pedidos.

## Pré-requisitos:

 * Ruby 3.1.0
 * Rails 7.0.3
* sqlite 3 1.4
 
### Gems Complementares
#### Testes

  * RSpec  https://rubygems.org/gems/rspec/versions/3.10.0
  * Capybara  https://rubygems.org/gems/capybara/versions/3.35.3

                                          
#### Autorização/Autenticação

  * Devise  https://github.com/heartcombo/devise#getting-started
 
 ## Instruções

Clone o projeto:

```sh
git clone git@github.com:AraceleSouza/Delivery-System.git
```

Instalação e execução:

```sh
bundle install               => instalar dependencias do projeto (o ruby 3.1.0 deve estar instalado)

bin/rails db:prepare db:seed => preparar e popular banco de dados

bundle exec rspec            => rodar testes

rails server                 => rodar servidor
```

Com o servidor rodando acesse [localhost](http://localhost:3000/)

## Funcionalidades:

#### Gerenciamento de Entregas
- Permite a visualização do status da entrega, atrasos e paradas não programadas. Todas essas informações ficam armazenadas em um único lugar, o que permite o acesso aos dados em tempo real e de forma rápida.

#### Definição de Rotas
 - Que otimiza o percurso a ser realizado pela frota e garante mais agilidade nas entregas.
 
#### Monitoramento de Veículos
- Permite identificar, a todo momento, onde o veículo está e por onde passou durante o percurso.


## Usuários


####  Administrador

- Possui acesso a todas as transportadoras cadastradas no sistema.
- Cadastra e envia para transportadoras ordens de serviço para retirada e entrega.
- Consegue editar uma ordem de serviço após cadastro.
- Pode cadastrar novas transportadoras no sistema ou desativá-las.
- Consulta valores de frete e prazos de entrega.


#### Usuário da Transportadora

- Possui acesso a todas as informações relacionadas a pedidos e veículos da sua transportadora.

- Consegue aprovar ou reprovar um pedido.

- Após a entrega for realizada , consegue finalizar o pedido no sistema.

- Cadastra novos veículos no sistema.

## Objetivo

Projeto realizado no programa TreinaDev08, com objetivo de proporcionar conhecimento suficiente para capacitar pessoas a exercer a profissão de desenvolvedor de software , com base sólida na linguagem de programação Ruby on Rails.



