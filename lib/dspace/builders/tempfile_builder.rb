module Dspace
  module Builders
    module TempfileBuilder

      def self.build(filename, contents = nil)
        file = Tempfile.new([sanitize_filename(filename), File.extname(filename)], encoding: 'ascii-8bit').tap do |f|
          f.write contents
          f.close
        end
      end

      private

      def self.sanitize_filename(filename)
        filename.strip do |name|
          # NOTE: File.basename doesn't work right with Windows paths on Unix
          # get only the filename, not the whole path
          name.gsub!(/^.*(\\|\/)/, '')
          # Strip out the non-ascii character
          name.gsub!(/[^0-9A-Za-z.\-]/, '_')
        end
      end

    end
  end
end
