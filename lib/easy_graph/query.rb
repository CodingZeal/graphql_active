module EasyGraph
  class Query
    def self.build(model)
      instance_eval do
        GraphQL::ObjectType.define do
          field model.to_s.downcase.to_sym do
          end

          field model.to_s.downcase.pluralize.to_sym do
          end
        end
      end
    end
  end
end
