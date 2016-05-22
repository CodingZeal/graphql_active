module GraphqlActive
  class AttributeBuilder
    attr_accessor :model

    def initialize(model)
      @model = model
    end

    def attributes
      names.zip(types).reduce({}) do |results, (field_name, field_type)|
        results[field_name] = type_def(field_name, field_type)
        results
      end
    end

    private

    def type_def(field_name, field_type)
      if field_name == :id
        "!types.ID"
      else
        "#{required(field_name)}types.#{field_type}"
      end
    end

    def required(field_name)
      "!" if presence_validations.include?(field_name)
    end

    def graphql_type(field_type)
      types = {
        integer: "Int",
        boolean: "Boolean",
        decimal: "Float", float: "Float",
        binary: "String", date: "String", datetime: "String",
        string: "String", text: "String", time: "String"
      }
      types[field_type]
    end

    def types
      model.columns.map(&:type).map { |field_type| graphql_type(field_type) }
    end

    def names
      model.columns.map(&:name).map(&:to_sym)
    end

    def presence_validations
      model.validators.reduce([]) do |result, validator|
        result << validator.attributes if presence_required?(validator)
        result
      end.flatten
    end

    def presence_required?(validator)
      validator.is_a?(ActiveRecord::Validations::PresenceValidator)
    end
  end
end
