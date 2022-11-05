class AddUserToSpaces < ActiveRecord::Migration[7.0]
  def change
    Space.destroy_all
    add_reference :spaces, :user, null: false, foreign_key: true
    add_reference :spaces, :place, null: false, foreign_key: true
    add_column :spaces, :dimensions, :string
    add_column :spaces, :highlight, :boolean
    remove_column :spaces, :district
    remove_foreign_key :spaces, column: :city_id
    remove_index :spaces, name: "index_spaces_on_city_id"
    remove_column :spaces, :city_id
  end
end
