class Category < ActiveRecord::Base
    has_many :books
    has_many :authors, through: :books

    validates :name, uniqueness: true
end
