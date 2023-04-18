# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.text :message
      t.boolean :term, default: false

      t.timestamps
    end
  end
end
