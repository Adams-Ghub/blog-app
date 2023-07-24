# frozen_string_literal: true

# Creates a foreign key in the Posts table to reference the Comments table
class AddPostsRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :posts, null: false, foreign_key: true
  end
end
