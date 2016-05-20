FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post title #{n}" }
    sequence(:body) { |n| "Post body #{n}" }

    after(:create) do |instance|
      create_list(:comment, 4, post: instance, commenter: User.all.sample)
    end
  end
end
