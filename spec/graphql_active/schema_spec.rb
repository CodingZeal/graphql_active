require "spec_helper"

RSpec.describe GraphqlActive::Schema do
  let(:schema) { described_class.build(model, fake_query) }
  let(:model) { User }
  let(:fake_query) { double "GraphqlActive::Query" }

  it "builds and returns the Schema" do
    expect(schema).to be_an_instance_of(GraphQL::Schema)
  end

  it "defines a query root" do
    expect(schema.query).to eq fake_query
  end
end
