# frozen_string_literal: true

# Creates a foreign key in the Users table to reference the Likes table
class AddUsersRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :users, null: false, foreign_key: true
  end
end
