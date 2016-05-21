module GraphqlActive
  class Schema
    def self.build(_model, query = GraphqlActive::Query)
      GraphQL::Schema.new(
        query: query # pass model into #build method
      )
    end
  end
end
