class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :showu, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
