# GraphqlActive

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql_active'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphql_active

## Usage

### Setup
- Install the gem (see above).
- Next, add a controller for your GraphQL endpoint: `rails g controller GraphqlActive query mutate`
- View the controller that was just generated and add a line of code to each method. When your done the controller should look like this:
```ruby
class GraphqlActiveController < ApplicationController
  def query
    GraphqlActive.query(params['query']) # can be changed to param key of your choosing
  end

  def mutate
    GraphqlActive.mutate(params['query']) # can be changed to param key of your choosing
  end
end
```
> Note: both the read method (`query`) and the write method (`mutate`) pull the query string from `params['query']`. This is to keep consistancy on the user end of the request. The methods for `query` and `mutate` are seperate so that you can omit them from the query string on the client side.

- Add routes to point to this controller:
```ruby
get '/graphql' => 'graphql_active#query'
post '/graphql' => 'graphql_active#mutate'
```
- And that's it :thumbsup: Now you will have access to your data via a Graphql style interface

### Using

- Any model that you want to expose a Graphql CRUD interface on, include the GraphqlActive hook in your ActiveRecord model like so:
```ruby
class User
  make_graphql_active
end
```

##### Finding a single record
```ruby
# Setup data
User.create(first_name: "Bob", last_name: "Example")

# Query
GraphqlActive.query('user(id: 1) { id, first_name, last_name }')

# Return data
{
  "data" => {
    "user" => {
      "id" => "1",
      "first_name" => "Bob",
      "last_name" => "Example"
    }
  }
}
```

##### Finding a collection
```ruby
# Setup data
User.create(first_name: "Foo", last_name: "Bar")
User.create(first_name: "Bob", last_name: "Biz")

# Query
GraphqlActive.query('users() { first_name, last_name }')

# Return data
{
  "data" => {
    "users" => [
      {
        "first_name" => "Foo",
        "last_name" => "Bar"
      },
      {
        "first_name" => "Bob",
        "last_name" => "Biz"
      }
    ]
  }
}
```

##### Finding a set of nested data
```ruby
# Setup data
user = User.create(first_name: "Foo", last_name: "Bar")

first_post = Post.create(title: "My Post", body: "Some stuff about awesome other stuff")

second_post = Post.create(title: "My Other Awesome Post", body: "More awesome inspiring stuff")

user.posts << [first_post, second_post]

first_post.comments << [
  Comment.create(body: "Great post"),
  Comment.create(body: "Thanks!")
]

# Query
GraphqlActive.query('user(id: 1) { first_name, posts { title, comments { body } } }')

# Return data
{
  "data" => {
    "user" => {
      "first_name" => "Foo",
      "posts" [
        {
          "title" => "My Post",
          "comments" => [
            {
              "body" => "Great post"
            },
            {
              "body" => "Thanks!"
            }
          ]
        },
        {
          "title" => "My Other Awesome Post",
          "comments" => []
        }
      ]
    }
  }
}

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/graphql_active.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
