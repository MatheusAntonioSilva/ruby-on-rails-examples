class CreateBook < ActiveRecord::Migration[7.0]

  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :public_url, null: false
      t.string :file_name, null: false
      t.references :user, foreign_key: true, null: false
      t.references :author, foreign_key: true, null: false

      t.timestamps
    end
  end
end
