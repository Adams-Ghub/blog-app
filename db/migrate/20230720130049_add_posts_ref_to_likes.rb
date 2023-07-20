# frozen_string_literal: true

# Creates a foreign key in the Posts table to reference the Likes table
class AddPostsRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :posts, null: false, foreign_key: true
  end
end
