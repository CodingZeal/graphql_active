class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: :user
  belongs_to :post
end
