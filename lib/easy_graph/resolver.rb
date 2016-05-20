module EasyGraph
  class Resolver
    def self.all(model)
      -> (_, _, _) { model.all }
    end

    def self.find(model)
      -> (_, arguments, _) { model.find(arguments["id"]) }
    end

    def self.create(model)
      -> (_, arguments, _) { model.create(arguments.to_h) }
    end

    def self.update(model)
      lambda do |_object, arguments, _context|
        model.update(arguments["id"], new_attributes(model, arguments.to_h))
      end
    end

    def self.new_attributes(model, arguments)
      model_attributes = model.find(arguments["id"]).attributes.except("id")
      model_attributes.merge(arguments.except("id"))
    end
  end
end
