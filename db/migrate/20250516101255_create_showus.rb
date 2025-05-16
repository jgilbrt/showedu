class CreateShowus < ActiveRecord::Migration[7.1]
  def change
    create_table :showus do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.string :youtube_url
      t.string :image_url

      t.timestamps
    end
  end
end
