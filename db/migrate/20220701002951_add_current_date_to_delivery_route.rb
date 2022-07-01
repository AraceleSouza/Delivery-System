class AddCurrentDateToDeliveryRoute < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_routes, :current_date, :date
  end
end
