module EasyGraph
  class Schema
    def self.build(model, query = EasyGraph::Query)
      GraphQL::Schema.new(
        query: query
      )
    end
  end
end
