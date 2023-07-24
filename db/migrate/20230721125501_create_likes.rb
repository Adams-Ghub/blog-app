# frozen_string_literal: true

# Creates the likes table in the database
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes, &:timestamps
  end
end
