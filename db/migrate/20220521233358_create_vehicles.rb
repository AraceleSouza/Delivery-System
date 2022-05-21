class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand
      t.string :year_fabrication
      t.string :model
      t.string :freight

      t.timestamps
    end
  end
end
