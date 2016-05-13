class Post < ActiveRecord::Base
  belongs_to :author, class_name: :user
  has_many :comments
end
