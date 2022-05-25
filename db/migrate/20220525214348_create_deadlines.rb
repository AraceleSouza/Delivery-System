class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.decimal :min_distance
      t.decimal :max_distance
      t.decimal :deadline_in_days
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
