class AddShippingCompanyToFunctionary < ActiveRecord::Migration[7.0]
  def change
    add_reference :functionaries, :shipping_company, null: true, foreign_key: true
  end
end
