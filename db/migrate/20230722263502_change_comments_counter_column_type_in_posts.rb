class ChangeCommentsCounterColumnTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :comments_counter, :integer, using: 'comments_counter::integer'
  end
end
