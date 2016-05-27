module GraphqlActive
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
      klass_name = (relation.class_name || relation.name.singularize).capitalize
      relation = relation.try(:delegate_reflection) || relation
      case relation.class.to_s
      when "ActiveRecord::Reflection::HasManyReflection"
        "-> { types[Type.build(#{klass_name})] }"
      when "ActiveRecord::Reflection::BelongsToReflection"
        "Type.build(#{klass_name})"
      else
        raise "Unknown RelationBuilder"
      end
    end
  end
end
