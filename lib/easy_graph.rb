require "graphql"
require "active_record"
require "inflections"

require "easy_graph/version"
require "easy_graph/relation_builder"
require "easy_graph/attribute_builder"
require "easy_graph/schema"
require "easy_graph/query"
require "easy_graph/mutation"
require "easy_graph/type"
require "easy_graph/resolver"

module EasyGraph
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
