require "spec_helper"

RSpec.describe EasyGraph::Relation do
  let(:easy_graph_relation) { described_class.new(model) }
  let(:model) { Post }

  context "has_many" do
    let(:model) { User }
    let(:expected_return) do
      {
        posts: OpenStruct.new(type: :has_many, relation_class: "Post"),
        comments: OpenStruct.new(type: :has_many, relation_class: "Comment")
      }
    end

    it "builds graphql has_many structure" do
      expect(easy_graph_relation.relations).to eq expected_return
    end
  end

  context "belongs_to" do
    let(:model) { Comment }
    let(:expected_return) do
      {
        post: OpenStruct.new(type: :belongs_to, relation_class: "Post"),
        commenter: OpenStruct.new(type: :belongs_to, relation_class: "User")
      }
    end

    it "builds graphql belongs_to structure" do
      expect(easy_graph_relation.relations).to eq expected_return
    end
  end
end
