class ChangeRoleDefaultToUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "normal"
  end
end
