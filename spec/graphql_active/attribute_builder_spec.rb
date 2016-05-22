require "spec_helper"

RSpec.describe GraphqlActive::AttributeBuilder do
  let(:easy_graph_attribute) { described_class.new(model) }
  let(:model) { User }
  let(:expected_return) do
    {
      id: "!types.ID",
      first_name: "!types.String",
      last_name: "types.String",
      age: "types.Int"
    }
  end

  it "builds out the attribute structure for graphql type" do
    expect(easy_graph_attribute.attributes).to eq expected_return
  end
end
