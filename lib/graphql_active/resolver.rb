module GraphqlActive
  class Resolver
    def self.resolve(model)
      lambda do |_object, arguments, _context|
        return model.find(arguments["id"]) if arguments["id"]
        model.all
      end
    end
  end
end
