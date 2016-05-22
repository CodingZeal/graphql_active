require "graphql"
require "active_record"
require "inflections"

require "graphql_active/version"
require "graphql_active/relation_builder"
require "graphql_active/attribute_builder"
require "graphql_active/schema"
require "graphql_active/query"
require "graphql_active/mutation"
require "graphql_active/type"
require "graphql_active/resolver"

module GraphqlActive
  def self.easy_query(query, model = nil)
    if model.nil? || !(model.ancestors.include? ActiveRecord::Base)
      raise ArgumentError.new, "#{model} is not an ActiveRecord class"
    end
    Schema.build(model).execute("query { #{query} }")
  end

  def self.easy_mutate(mutation, model = nil)
    if model.nil? || !(model.ancestors.include? ActiveRecord::Base)
      raise ArgumentError.new, "#{model} is not an ActiveRecord class"
    end
    Schema.build(model).execute("mutation { #{mutation} }")
  end
end
