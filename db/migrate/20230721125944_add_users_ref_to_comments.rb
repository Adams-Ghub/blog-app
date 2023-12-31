# frozen_string_literal: true

# Creates a foreign key in the Users table to reference the Comments table
class AddUsersRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :users, null: false, foreign_key: true
  end
end
