class CreatePriceSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :price_settings do |t|
      t.decimal :min_weight
      t.decimal :max_weight
      t.decimal :max_cubic_meter
      t.decimal :min_cubic_meter
      t.decimal :distance_value
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
