class CreateShippingCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_companies do |t|
      t.string :fantasy_name
      t.string :corporate_name
      t.string :email
      t.integer :CNPJ
      t.string :address
      t.string :city
      t.string :state
      t.integer :CEP

      t.timestamps
    end
  end
end
