# frozen_string_literal: true

class RenameImageUrlToImage < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :image_url, :image
  end
end
