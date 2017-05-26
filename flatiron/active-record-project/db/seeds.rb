Author.create(name: "Paula Hawkins")
Author.create(name: "Jane Austen")

Category.create(name: "Romance")
Category.create(name: "Thriller")

Book.create(title: "Girl on the Train")
Book.create(title: "Sense and Sensibility")

User.create(name: "Dr. Who")
User.create(name: "Melanie")

Book.create(title: "Emma", author_id: 2, category_id: 1)
