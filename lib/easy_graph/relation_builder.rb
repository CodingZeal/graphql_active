module EasyGraph
  class RelationBuilder
    attr_accessor :model

    def initialize(model)
      @model = model
    end

    def relations
      model.reflections.reduce({}) do |relations, (_, relation)|
        relations[relation.name] = association_type_for(relation)
        relations
      end
    end

    private

    def association_type_for(relation)
      klass = (relation.class_name || relation.name.singularize).capitalize
      case relation.class.to_s
      when "ActiveRecord::Reflection::HasManyReflection"
        "-> { types[Type.build(#{klass})] }"
      when "ActiveRecord::Reflection::BelongsToReflection"
        "Type.build(#{klass})"
      else
        raise "Unknown RelationBuilder"
      end
    end
  end
end
