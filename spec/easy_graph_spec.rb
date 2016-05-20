require 'spec_helper'

describe EasyGraph do
  before do
    FactoryGirl.create_list(:user, 2)
  end

  context ".easy_query" do
    let(:non_active_record_class) { Struct.new(:first_name, :last_name) }
    
    it "raises an error if class passed is not ActiveRecord" do
      expect{
        described_class.easy_query(nil, non_active_record_class)
      }.to raise_error ArgumentError
    end
  end

  context "finding a single record" do
    let(:query) { 'user(id: 1) { first_name, last_name, age }' }
    let(:result) do
      {
        "data" => {
          "user" => {
            "first_name" => "first_name_1",
            "last_name" => "last_name_1",
            "age" => 10
          }
        }
      }
    end

    it "returns the expected data" do
      expect(described_class.easy_query(query, User)).to eq result
    end
  end

  context "finding all the records" do
    let(:query) { 'users() { first_name, last_name, age }' }
    let(:result) do
      {
        "data" => {
          "users" => [
            {
              "first_name" => "first_name_1",
              "last_name" => "last_name_1",
              "age" => 10
            },
            {
              "first_name" => "first_name_2",
              "last_name" => "last_name_2",
              "age" => 10
            }
          ]
        }
      }
    end

    it "returns the expected data" do
      expect(described_class.easy_query(query, User)).to eq result
    end
  end

  context "finding record with nested data via has_many relationship" do
    let(:query) { 'user(id: 1) { first_name, last_name, age, posts {title} }' }
    let(:result) do
      {
        "data" => {
          "user" => {
            "first_name" => "first_name_1",
            "last_name" => "last_name_1",
            "age" => 10,
            "posts" => [
              { "title" => "Post title 1" },
              { "title" => "Post title 2" },
              { "title" => "Post title 3" }
            ]
          }
        }
      }
    end

    it "returns the expected data" do
      expect(described_class.easy_query(query, User)).to eq result
    end
  end

  context "finding record with parent data via belongs_to relationship" do
    let(:post) { Post.find(1) }
    let(:post_author) { post.author }
    let(:query) { 'post(id: 1) { title, body, author { first_name, age } }' }
    let(:result) do
      {
        "data" => {
          "post" => {
            "title" => "Post title 1",
            "body" => "Post body 1",
            "author" => {
              "first_name" => post_author.first_name,
              "age" => post_author.age
            }
          }
        }
      }
    end

    it "returns the expected data" do
      expect(described_class.easy_query(query, Post)).to eq result
    end
  end

  context "creating a record" do
    let(:mutation) do
      'create_user(first_name: "TEST", age: 25) { first_name }'
    end
    let(:result) do
      {
        "data" => {
          "create_user" => {
            "first_name" => "TEST"
          }
        }
      }
    end

    it "saves to the database and returns the expected data" do
      expect(described_class.easy_mutate(mutation, User)).to eq result
      expect(User.last.first_name).to eq "TEST"
      expect(User.last.last_name).to be_nil
    end
  end

  context "updating a record" do
    let(:mutation) do
      'update_user(id: 1, first_name: "TEST", age: 25) { first_name, age }'
    end
    let(:result) do
      {
        "data" => {
          "update_user" => {
            "first_name" => "TEST",
            "age" => 25
          }
        }
      }
    end

    it "saves to the database and returns the expected data" do
      expect(described_class.easy_mutate(mutation, User)).to eq result
      expect(User.first.first_name).to eq "TEST"
      expect(User.first.age).to eq 25
    end
  end
end
