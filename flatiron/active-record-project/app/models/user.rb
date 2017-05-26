require 'pry'

class User < ActiveRecord::Base
  has_many :user_books
  has_many :books, through: :user_books

  validates :name, uniqueness: true

  def check_out_book(book, due_date)
    UserBook.create(user: self, book: book, due_date: due_date)

  end

  def return_book(book)
    entry = UserBook.find_by(user_id: self.id, book_id: book.id, returned: false)
    # puts "Entry was found. ID: #{entry.id} #{entry.inspect}"
    UserBook.update(entry.id, :returned => true)
  end
end
