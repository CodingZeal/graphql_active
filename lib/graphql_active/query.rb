module GraphqlActive
  class Query
    def self.build(model) # rubocop:disable AbcSize, MethodLength
      GraphQL::ObjectType.define do
        field model.to_s.downcase.to_sym do
          type Type.build(model)
          argument :id, !types.ID
          resolve Resolver.find(model)
        end

        field model.to_s.downcase.pluralize.to_sym do
          type types[Type.build(model)]
          resolve Resolver.all(model)
        end
      end
    end
  end
end
