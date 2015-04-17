# More logical way to require 'dspace-rest-client'
require File.dirname(__FILE__) + '/dspacerestclient'

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

require_all File.dirname(__FILE__) + '/dspacerest/'