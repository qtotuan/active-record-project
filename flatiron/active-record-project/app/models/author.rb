class Author < ActiveRecord::Base
  has_many :books
  has_many :categories, through: :books

  validates :name, uniqueness: true
end
