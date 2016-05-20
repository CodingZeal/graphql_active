$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "easy_graph"
require "sqlite3"
require "graphql"
require "active_record"
require "factory_girl"
require "pry-byebug"
require "require_all"
require "database_cleaner"
require_relative "support/database_cleaner"
require_rel "models"
require_rel "factories"

RSpec.configure do |config|
  config.order = "random"
end
