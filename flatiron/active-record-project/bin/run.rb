require_relative '../config/environment.rb'
require 'date'
# require_relative '../app/models/user.rb'

class CLI
  attr_accessor :user

  def initialize
    @user = user
  end

  def prompt_welcome_message
    puts "Welcome to NYC Library!"
    puts ""
    puts "Please enter your user name:"
    puts "(Type 'exit' anytime to close the program.)"
  end

  def prompt_menu
    puts ""
    puts "------------"
    puts "MENU"
    puts "borrow: Borrow a book"
    puts "return: Return a book"
    puts "categories: Display all categories"
    puts "my books: List all your currently borrowed books"
    puts ""
    puts "exit: close the program"
    puts "menu: display this menu"
    puts "------------"
  end

  def ask_for_input
    puts ""
    puts "What would you like to do next?"
    answer = gets.chomp
  end

  def sign_up_user
    puts "Please choose a user name:"
    answer = gets.chomp
    @user = User.new(name: answer)
    puts "Your user account was created."
  end

  def log_in_or_create_user
    answer = gets.chomp
    exit(0) if answer == 'exit'
    @user = User.find_by_name(answer)
    while user.nil? do
      puts "User not found. User names are case sensitive."
      puts "Please re-enter your name or type 'sign up' to create a new user account."
      answer = gets.chomp
      if answer == "sign up"
        sign_up_user
      else
        @user = User.find_by_name("#{answer}")
        exit(0) if answer == "exit"
      end
    end
    puts ""
    puts "Hello, #{user.name}!"
    puts "This is your menu:"
    prompt_menu
  end

  def show_categories
    puts ""
    puts "Please choose a book category:"
    puts "------------"
    Category.all.each do |category|
      puts category.name
    end
    puts "------------"
    answer = gets.chomp
    puts ""

    # Display books in category
    category = Category.find_by_name(answer)
    case answer
    when "exit"
      exit(0)
    when "menu"
      prompt_menu
    else
      while category.nil? do
        puts "Category not found. Please check the spelling and re-enter:"
        answer = gets.chomp
        category = Category.find_by_name(answer)
        exit(0) if answer == "exit"
      end
    end

    puts "These are the books available in #{category.name}:"
    category.books.each do |book|
      puts "'#{book.title}' by #{book.author.name}"
    end
  end

  def get_book_from_user
    puts ""
    puts "Please type in the title of the book:"
    answer = gets.chomp
    book = Book.find_by_title(answer)

    case answer
    when "exit"
      exit(0)
    when "menu"
      prompt_menu
    else
      while book.nil? do
        puts "Book not found. Please check the spelling and re-enter:"
        answer = gets.chomp
        exit(0) if answer == "exit"
        book = Book.find_by_title(answer)
      end
    end
    book
  end

  def borrow_book
    puts ""
    puts "Which book would you like to borrow?"
    book = get_book_from_user

    puts ""
    puts "Would you like to check out '#{book.title}?' (y/n)"
    answer = gets.chomp

    case answer
    when "exit"
      exit(0)
    when "menu"
      prompt_menu
    when "y"
      return_date = (Date.today + 30).to_s
      user.check_out_book(book, return_date)
      puts "Thanks for checking out '#{book.title}'."
      puts "Please return it by #{return_date}."
    when "n"
      puts "Return to main menu!"
      return
    else
      while answer.downcase != "y" do
        puts ""
        puts "Please type y/n or exit"
        answer = gets.chomp
        exit(0) if answer == "exit"
      end
    end
  end

  def return_book
    # Return book
    puts ""
    book = get_book_from_user

    user.return_book(book)
    puts ""
    puts "Thank you for returning #{book.title}."
  end

  def show_all_user_books
    all_books = UserBook.where(user: user, returned: false)
    if all_books.empty?
      puts ""
      puts "You have currently no books."
    else
      all_books.each_with_index do |entry, index|
        # puts "ID: #{entry.id} #{entry.inspect}"
        puts "#{index + 1}. #{entry.book.title} (return by: #{entry.due_date})"
      end
    end
  end

  def error_message
    puts ""
    puts "Command not found."
    puts "Please type again:"
  end

  def start
    # puts User.all.inspect
    # puts UserBook.all.inspect

    prompt_welcome_message
    log_in_or_create_user
    while true do
      answer = ask_for_input
      case answer
      when "exit"
        exit(0)
      when "menu"
        prompt_menu
      when "categories"
        show_categories
      when "borrow"
        borrow_book
      when "return"
        return_book
      when "my books"
        show_all_user_books
      else
        error_message
      end
    end
  end
end

CLI.new.start
