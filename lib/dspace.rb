require "forwardable"
require "json"
require "resource_kit"

require_relative "dspace/version"
require_relative "dspace/resources/community_resource"
require_relative "dspace/resources/collection_resource"
require_relative "dspace/builders/hash_builder"
require_relative "dspace/builders/model_builder"
require_relative "dspace/community"
require_relative "dspace/collection"

module Dspace

  class NotAuthorizedError < StandardError; end

end
