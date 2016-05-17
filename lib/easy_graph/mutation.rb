module EasyGraph
  class Mutation
    def self.build(model) ## rubocop:disable MethodLength, AbcSize
      GraphQL::ObjectType.define do
        name "#{model} mutation"
        description Mutation.description(model)

        field "create_#{model.to_s.downcase}" do
        end

        field "update_#{model.to_s.downcase}" do
        end
      end
    end

    def self.description(model)
      "Mutation root for #{model} defines the create_#{model.to_s.downcase}
      and update_#{model.to_s.downcase} mutation types"
    end
  end
end
