require "spec_helper"

RSpec.describe GraphqlActive::Schema do
  let(:schema) { described_class.build(model) }
  let(:model) { User }

  it "builds and returns the Schema" do
    expect(schema).to be_an_instance_of(GraphQL::Schema)
  end

  it "defines a query root" do
    expect(schema.query).to be_an_instance_of GraphQL::ObjectType
  end

  it "defines a mutation root" do
    expect(schema.mutation).to be_an_instance_of GraphQL::ObjectType
  end
end
