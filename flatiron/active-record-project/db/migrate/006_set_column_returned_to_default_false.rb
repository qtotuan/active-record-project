class SetColumnReturnedToDefaultFalse < ActiveRecord::Migration[4.2]
  def change
    change_column :user_books, :returned, :boolean, :default => false
  end
end
