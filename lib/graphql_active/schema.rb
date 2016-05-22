module GraphqlActive
  class Schema
    def self.build(model, query = Query, mutation = Mutation)
      GraphQL::Schema.new(
        query: query.build(model),
        mutation: mutation.build(model)
      )
    end
  end
end
