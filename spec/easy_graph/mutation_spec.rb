require "spec_helper"

RSpec.describe EasyGraph::Mutation do
  let(:query) { described_class.build(User) }

  it "defines `create` and `update` mutation types" do
    query_fields = query.fields.keys
    wrong_fields = query_fields - ["create_user", "update_user"]
    expect(wrong_fields).to be_empty, "did not expect fields #{wrong_fields}"
  end
end
