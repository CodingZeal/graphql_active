require "spec_helper"

RSpec.describe EasyGraph::AttributeBuilder do
  let(:easy_graph_attribute) { described_class.new(model) }
  let(:model) { User }
  let(:expected_return) do
    {
      id: "ID",
      first_name: "String",
      last_name: "String",
      age: "Int"
    }
  end

  it "builds out the attribute structure for graphql type" do
    expect(easy_graph_attribute.attributes).to eq expected_return
  end
end
