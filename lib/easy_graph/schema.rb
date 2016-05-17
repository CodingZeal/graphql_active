module EasyGraph
  class Schema
    def self.build(_model, query = EasyGraph::Query)
      GraphQL::Schema.new(
        query: query # pass model into #build method
      )
    end
  end
end
