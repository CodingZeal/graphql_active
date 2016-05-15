module EasyGraph
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
        binary: "String",
        boolean: "Boolean",
        date: "String",
        datetime: "String",
        decimal: "Float",
        float: "Float",
        integer: "Int",
        string: "String",
        text: "String",
        time: "String"
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
