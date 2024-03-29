FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Book #{n}"}
    description 'Rails Test Prescriptions is a comprehensive guide to testing Rails applications,
      covering Test-Driven Development from both a theoretical perspective (why to test) and from
      a practical perspective (how to test effectively). It covers the core Rails testing tools
      and procedures for Rails 2 and Rails 3, and introduces popular add-ons, including Cucumber,
      Shoulda, Machinist, Mocha, and Rcov.'
    image_url 'rtp.jpg'
    price 34.95
    association :category
  end
end
