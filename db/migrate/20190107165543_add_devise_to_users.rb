# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,              null: false, default: ""
      t.string :password_digest,    limit: 191, null: false
      t.string :remember_token,     limit: 191
      t.integer :university
      t.integer :faculty
      t.string :major
      t.integer :point

      t.timestamps null: false
    end
  end
end
