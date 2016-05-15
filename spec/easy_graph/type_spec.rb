require "spec_helper"

RSpec.describe EasyGraph::Type do
  let(:type) { described_class.build(User) }

  it "defines a name" do
    expect(type.name).to eq "User"
  end

  it "defines a description" do
    expect(type.description).to eq "The type definition for the User class"
  end

  ["id", "first_name", "last_name", "age"].each do |field_name|
    it "has the field #{field_name}" do
      expect(type.fields.keys).to include field_name
    end
  end

  ["posts", "comments"].each do |relation_name|
    it "defines a relation to #{relation_name}" do
      expect(type.fields.keys).to include relation_name
    end
  end
end
