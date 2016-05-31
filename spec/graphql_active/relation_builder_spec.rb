require "spec_helper"

RSpec.describe GraphqlActive::RelationBuilder do
  let(:easy_graph_relation) { described_class.new(model) }
  let(:model) { Post }

  context "has_many" do
    let(:model) { User }
    let(:expected_return) do
      {
        posts: "-> { types[Type.build(::Post)] }",
        comments: "-> { types[Type.build(::Comment)] }"
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
        post: "Type.build(::Post)",
        commenter: "Type.build(::User)"
      }
    end

    it "builds graphql belongs_to structure" do
      expect(easy_graph_relation.relations).to eq expected_return
    end
  end
end
