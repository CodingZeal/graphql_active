ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.integer :age
  end

  create_table :posts, :force => true do |t|
    t.string :title
    t.text :body
    t.integer :user_id
  end

  create_table :comments, :force => true do |t|
    t.string :body
    t.integer :post_id
    t.integer :user_id
  end
end
