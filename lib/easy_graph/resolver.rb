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
        model.find(arguments.delete("id")).update(arguments.to_h)
      end
    end
  end
end
