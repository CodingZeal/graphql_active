module GraphqlActive
  class Mutation
    def self.build(model) # rubocop:disable MethodLength, AbcSize
      GraphQL::ObjectType.define do
        name "#{model} mutation"
        description Mutation.description(model)

        field "create_#{model.to_s.downcase}".to_sym do
          type Type.build(model)
          Mutation.attributes(model).each do |field_name, field_type|
            next if field_name == :id
            argument field_name, eval(field_type) # rubocop:disable Eval
          end
          resolve Resolver.create(model)
        end

        field "update_#{model.to_s.downcase}".to_sym do
          type Type.build(model)
          Mutation.attributes(model).each do |field_name, field_type|
            argument field_name, eval(field_type) # rubocop:disable Eval
          end
          resolve Resolver.update(model)
        end
      end
    end

    def self.description(model)
      "Mutation root for #{model} defines the create_#{model.to_s.downcase}
      and update_#{model.to_s.downcase} mutation types"
    end

    def self.attributes(model)
      GraphqlActive::AttributeBuilder.new(model).attributes
    end
  end
end
