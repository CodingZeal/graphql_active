FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
    age 10

    after(:create) do |instance|
      create_list(:post, 3, author: instance)
    end
  end
end
