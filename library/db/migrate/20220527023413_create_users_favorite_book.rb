class CreateUsersFavoriteBook < ActiveRecord::Migration[7.0]
  def up
    create_table :users_favorite_books do |t|
      t.references :user, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false
      t.timestamps
    end

    add_index :users_favorite_books, [:user_id, :book_id], unique: true
  end

  def down
    drop_table :users_favorite_books
  end
end
