require "forwardable"
require "json"
require "resource_kit"
require "faraday"
require "active_support/all"

require_relative "dspace/version"
require_relative "dspace/resources/schema_registry_resource"
require_relative "dspace/resources/community_resource"
require_relative "dspace/resources/collection_resource"
require_relative "dspace/resources/authentication_resource"
require_relative "dspace/resources/bitstream_resource"
require_relative "dspace/resources/status_resource"
require_relative "dspace/resources/item_resource"
require_relative "dspace/builders/hash_builder"
require_relative "dspace/builders/model_builder"
require_relative "dspace/builders/tempfile_builder"
require_relative "dspace/community"
require_relative "dspace/collection"
require_relative "dspace/item"
require_relative "dspace/metadata"
require_relative "dspace/schema"
require_relative "dspace/metadata_field"
require_relative "dspace/bitstream"
require_relative "dspace/policy"
require_relative "dspace/client"

module Dspace

  class NotAuthorizedError < StandardError; end
  class NotFoundError < StandardError; end
  class MethodNotAllowedError < StandardError; end
  class UnsupportedMediaTypeError < StandardError; end
  class ServerError < StandardError; end
  class InvalidTokenError < StandardError; end
  class InvalidCredentialsError < StandardError; end

end
