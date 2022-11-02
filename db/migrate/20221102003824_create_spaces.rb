class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.references :city, null: false, foreign_key: true
      t.integer :kind
      t.string :title
      t.string :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
