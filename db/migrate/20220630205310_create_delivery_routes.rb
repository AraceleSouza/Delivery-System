class CreateDeliveryRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_routes do |t|
      t.date :estimated_delivery_date
      t.string :current_address
      t.string :exit_address
      t.references :service_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
