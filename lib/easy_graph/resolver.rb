module EasyGraph
  class Resolver
    def self.resolve(model)
      -> (object, arguments, context) {
        return model.find(arguments["id"]) if arguments["id"]
        model.all
      }
    end
  end
end
