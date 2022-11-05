class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.references :city, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.boolean :is_active
      t.string :district

      t.timestamps
    end
  end
end
