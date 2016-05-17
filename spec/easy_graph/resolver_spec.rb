require "spec_helper"

RSpec.describe EasyGraph::Resolver do
  let(:model) { User }

  before do
    model.create(
      [
        {
          first_name: "Foo",
          last_name: "Bar",
          age: 20
        },
        {
          first_name: "Fiz",
          last_name: "Buz",
          age: 55
        }
      ]
    )
  end

  it "returns single item when calling #{described_class}.find" do
    params = [nil, { "id" => 1 }, nil]
    expect(described_class.find(model).call(*params)).to eq model.first
  end

  it "retruns a colection when calling #{described_class}.all" do
    params = [nil, {}, nil]
    expect(described_class.all(model).call(*params)).to eq model.all
  end

  it "changes an item when calling #{described_class}.update" do
    params = [
      nil, { "id" => 1, "first_name" => "My new name", "age" => 1000 }, nil
    ]
    described_class.update(model).call(*params)
    expect(model.first.first_name).to eq "My new name"
    expect(model.first.age).to eq 1000
  end

  it "changes an item when calling #{described_class}.create" do
    params = [
      nil, { "first_name" => "EXAMPLE", "age" => 1000 }, nil
    ]
    described_class.create(model).call(*params)
    expect(model.last.first_name).to eq "EXAMPLE"
  end
end
