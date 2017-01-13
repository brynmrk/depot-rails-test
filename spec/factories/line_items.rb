FactoryGirl.define do
  factory :line_item do
    # product_id 1
    association :product
    cart_id 1
  end

  factory :carted_line_item, parent: :line_item do
    order_id nil
    cart_id 1
    quantity 1
  end

  factory :ordered_line_item, parent: :line_item do
    order_id 1
    cart_id nil
    quantity 1
  end
end
