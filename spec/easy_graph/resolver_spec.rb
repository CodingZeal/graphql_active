require "spec_helper"

RSpec.describe EasyGraph::Resolver do
  let(:model) { User }

  let!(:users) do
    model.create([
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
    ])
  end

  it "returns single item if id given" do
    params = [nil, { "id" => 1 }, nil]
    expect(described_class.resolve(model).call(*params)).to eq users.first
  end

  it "retruns a colection if no id is given" do
    params = [nil, {}, nil]
    expect(described_class.resolve(model).call(*params)).to eq users
  end
end
