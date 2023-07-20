# frozen_string_literal: true

# Changes the user_id to author_id in the Posts table
class RenameUsersIdToAuthorIdInPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :users_id, :author_id
  end
end
