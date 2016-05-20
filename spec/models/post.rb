class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
