class CreateUnsplashPhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :unsplash_photos do |t|
      t.string :url
      t.string :category

      t.timestamps
    end
  end
end
