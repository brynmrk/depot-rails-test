FactoryGirl.define do
  factory :order do
    name "First Test Order"
    email "firsttestorder@email.com"
    address " Test St Brgy. Test, Test City Test"
    pay_type "Check"
  end
end
