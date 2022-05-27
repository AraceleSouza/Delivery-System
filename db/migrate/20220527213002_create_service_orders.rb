class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.references :shipping_company, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :product_model, null: false, foreign_key: true
      t.string :full_address
      t.string :customer_address
      t.string :customer_name
      t.date :estimated_delivery_date
      t.string :integer, default: 0

      t.timestamps
    end
  end
end
