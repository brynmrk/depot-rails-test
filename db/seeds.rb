Category.delete_all
Category.create!(
  name: 'Fiction',
  description: %{This book is about Fiction.}
)
# . . .
Category.create!(
  name: 'Architecture',
  description: %{This book is about Architecture.}
)
# . . .
Category.create!(
  name: 'Adventure',
  description: %{This book is about Adventure.}
)
# . . .
Category.create!(
  name: 'Biography',
  description: %{This book is about Biography.}
)
# . . .
Category.create!(
  name: 'Programming',
  description: %{This book is about Programming.}
)

Product.delete_all
Product.create!(title: 'CoffeeScript',
  category_id: 1,
  description:
    %{CoffeeScript is JavaScript done right. It provides all of JavaScript's functionality wrapped in a cleaner, more succinct syntax. In the first book on this exciting new language, CoffeeScript guru Trevor Burnham shows you how to hold onto all the power and flexibility of JavaScript while writing clearer, cleaner, and safer code.},
  image_url:   'cs.jpg',
  price: 36.00)
# . . .
Product.create!(title: 'Programming Ruby 1.9 & 2.0',
  category_id: 2,
  description: %{Ruby is the fastest growing and most exciting dynamic language out there. If you need to get working programs delivered fast, you should add Ruby to your toolbox.},
  image_url: 'ruby.jpg',
  price: 49.95)
# . . .
Product.create!(title: 'Rails Test Prescriptions',
  category_id: 3,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'rtp.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 1',
  category_id: 4,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 2',
  category_id: 5,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 3',
  category_id: 1,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 4',
  category_id: 2,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 5',
  category_id: 3,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 6',
  category_id: 4,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 7',
  category_id: 5,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 8',
  category_id: 1,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 9',
  category_id: 2,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 10',
  category_id: 3,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 11',
  category_id: 4,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 12',
  category_id: 5,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 13',
  category_id: 1,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 14',
  category_id: 2,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 15',
  category_id: 3,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 16',
  category_id: 4,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
# . . .
Product.create!(title: 'Book 17',
  category_id: 5,
  description: %{Rails Test Prescriptions is a comprehensive guide to testing Rails applications, covering Test-Driven Development from both a theoretical perspective (why to test) and from a practical perspective (how to test effectively). It covers the core Rails testing tools and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber, Shoulda, Machinist, Mocha, and Rcov.},
  image_url: 'cs.jpg',
  price: 34.95)
