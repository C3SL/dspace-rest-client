module Dspace
  module Builders
    module TempfileBuilder

      def self.build(filename, contents = nil, bitstreams_path = '/tmp')
        Tempfile.new([sanitize_filename(filename), File.extname(filename)], bitstreams_path, encoding: 'ascii-8bit').tap do |f|
          f.write contents
          f.close
        end
      end

      def self.sanitize_filename(filename)
        filename.strip!
        # NOTE: File.basename doesn't work right with Windows paths on Unix
        # get only the filename, not the whole path
        filename.gsub!(/^.*(\\|\/)/, '')
        # Strip out the non-ascii character
        filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
      end

    end
  end
end
