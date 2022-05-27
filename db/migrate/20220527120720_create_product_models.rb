class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.decimal :weight
      t.decimal :width
      t.decimal :height
      t.decimal :depth
      t.string :sku
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
