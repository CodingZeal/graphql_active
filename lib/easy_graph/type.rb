module EasyGraph
  class Type
    def self.build(model)
      GraphQL::ObjectType.define do
        name model.to_s
        description "The type definition for the #{model} class"

        Type.attributes(model).each do |field_name, field_type|
          field field_name, eval(field_type) # rubocop:disable Eval
        end

        Type.relations(model).each do |relation_name, relation_type|
          field relation_name, eval(relation_type) # rubocop:disable Eval
        end
      end
    end

    def self.relations(model)
      EasyGraph::RelationBuilder.new(model).relations
    end

    def self.attributes(model)
      EasyGraph::AttributeBuilder.new(model).attributes
    end
  end
end
