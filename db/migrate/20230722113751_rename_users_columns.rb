class RenameUsersColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :PostCounter, :post_counter 
  end
end
