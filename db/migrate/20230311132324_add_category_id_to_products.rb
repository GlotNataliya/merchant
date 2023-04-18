# frozen_string_literal: true

class AddCategoryIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :category_id, :integer
  end
end
