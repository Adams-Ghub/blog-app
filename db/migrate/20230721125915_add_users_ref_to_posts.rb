# frozen_string_literal: true

# Creates a foreign key in the Users table to reference the Posts table
class AddUsersRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :users, null: false, foreign_key: true
  end
end
