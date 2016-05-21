module GraphqlActive
  class AttributeBuilder
    attr_accessor :model

    def initialize(model)
      @model = model
    end

    def attributes
      names.zip(types).reduce({}) do |results, (name, type)|
        type = "ID" if name == :id
        results[name] = "!types.#{type}"
        results
      end
    end

    private

    def graphql_type(type)
      types = {
        integer: "Int",
        boolean: "Boolean",
        decimal: "Float", float: "Float",
        binary: "String", date: "String", datetime: "String",
        string: "String", text: "String", time: "String"
      }
      types[type]
    end

    def types
      model.columns.map(&:type).map { |type| graphql_type(type) }
    end

    def names
      model.columns.map(&:name).map(&:to_sym)
    end
  end
end
