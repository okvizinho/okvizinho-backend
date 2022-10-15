class AddIsActiveToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :is_active, :boolean
  end
end
