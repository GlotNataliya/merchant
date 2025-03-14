# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :stripe_product_id
      t.string :stripe_price_id
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.string :currency, default: "usd"
      t.integer :stock, default: 0
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
