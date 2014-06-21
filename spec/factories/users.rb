FactoryGirl.define do

  factory :user do
    name "Chris Victor"
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
  end

end

