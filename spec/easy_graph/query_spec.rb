require "spec_helper"

RSpec.describe EasyGraph::Query do
  let(:query) { described_class.build(User) }

  it "defines ActiveRecord#all and ActiveRecord#find query types" do
    query_fields = query.fields.keys
    wrong_fields = query_fields - ["user", "users"]
    expect(wrong_fields).to be_empty, "did not expect fields #{wrong_fields}"
  end
end
