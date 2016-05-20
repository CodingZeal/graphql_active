require "spec_helper"

RSpec.describe EasyGraph::Resolver do
  let(:model) { User }

  before do
    FactoryGirl.create_list(:user, 2)
  end

  context ".find" do
    it "returns the model instance that matches the id argument passed" do
      params = [nil, { "id" => 1 }, nil]
      expect(described_class.find(model).call(*params)).to eq model.first
    end
  end

  context ".all" do
    it "returns the entire collection of the model" do
      params = [nil, {}, nil]
      expect(described_class.all(model).call(*params)).to eq model.all
    end
  end

  context ".update" do
    let(:first_name) { "EXAMPLE" }
    let(:age) { 1000 }

    before do
      params = [
        nil, { "id" => 1, "first_name" => first_name, "age" => age }, nil
      ]
      described_class.update(model).call(*params)
    end

    it "changes the new values that were passed in" do
      expect(model.first.first_name).to eq "EXAMPLE"
      expect(model.first.age).to eq 1000
    end

    it "dosen't overwrite arguments with nil" do
      expect(model.first.last_name).to eq "last_name_1"
    end

    context "when setting a value to nil" do
      let(:age) { nil }

      it "sets the appropiate value to nil" do
        expect(model.first.age).to be_nil
      end
    end
  end

  context ".create" do
    it "creates a new model with the arguments passed in" do
      params = [
        nil, { "first_name" => "EXAMPLE", "age" => 1000 }, nil
      ]
      described_class.create(model).call(*params)
      expect(model.last.first_name).to eq "EXAMPLE"
    end
  end

  it "builds attributes for updating model" do
    attributes = {
      "id" => 1,
      "first_name" => "FOO",
      "age" => 20
    }
    expected = {
      "first_name" => "FOO",
      "last_name" => "last_name_1",
      "age" => 20
    }
    expect(described_class.new_attributes(model, attributes)).to eq expected
  end
end
