# frozen_string_literal: true

# Creates the users table in the database
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :PostCounter

      t.timestamps
    end
  end
end
