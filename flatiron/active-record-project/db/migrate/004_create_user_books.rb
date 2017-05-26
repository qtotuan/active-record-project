class CreateUserBooks < ActiveRecord::Migration[4.2]
  def change
    create_table :user_books do |t|
      t.integer :book_id
      t.integer :user_id
      t.boolean :returned
      t.datetime :due_date

      t.timestamp
    end
  end
end
