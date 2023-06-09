# frozen_string_literal: true

class AddCurrencyToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :currency, :string, default: "usd"
  end
end
