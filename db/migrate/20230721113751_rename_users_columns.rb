class RenameUsersColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :post_couter, :post_counter 
  end
end
