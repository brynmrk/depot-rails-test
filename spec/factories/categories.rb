FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}"}
    description 'This book is about Fiction.'
  end
end
