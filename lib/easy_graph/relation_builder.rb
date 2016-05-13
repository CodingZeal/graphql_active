module EasyGraph
  class RelationBuilder
    attr_accessor :model

    def initialize(model)
      @model = model
    end

    def relations
      model.reflections.reduce({}) do |relations, (_, relation)|
        relations[relation.name] = OpenStruct.new(
          type: association_type_for(relation),
          relation_class: (relation.class_name || relation.name.singularize).capitalize
        )
        relations
      end
    end

    private

    def association_type_for(relation)
      case relation.class.to_s
      when "ActiveRecord::Reflection::HasManyReflection" then :has_many
      when "ActiveRecord::Reflection::BelongsToReflection" then :belongs_to
      else
        raise "Unknown RelationBuilder"
      end
    end
  end
end
