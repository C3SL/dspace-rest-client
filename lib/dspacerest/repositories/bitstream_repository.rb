module DSpaceRest
  module Repositories
    class BitstreamRepository < AbstractRepository

      # Bitstreams are files. They have a filename, size (in bytes), and a file format.
      # Typically in DSpace, the Bitstream will the "full text" article, or some other media.
      # Some files are the actual file that was uploaded (tagged with bundleName:ORIGINAL),
      # others are DSpace-generated files that are derivatives or renditions, such as text-extraction, or thumbnails.
      # You can download files/bitstreams.
      # DSpace doesn't really limit the type of files that it takes in, so this could be PDF, JPG, audio, video, zip,
      # or other.
      # Also, the logo for a Collection or a Community, is also a Bitstream.

      # √ GET /bitstreams - Return all bitstreams in DSpace.
      # √ GET /bitstreams/{bitstream id} - Return bitstream.
      # GET /bitstreams/{bitstream id}/policy - Return bitstream policies.
      # √ GET /bitstreams/{bitstream id}/retrieve - Return data of bitstream.
      # POST /bitstreams/{bitstream id}/policy - Add policy to item. You must post a ResourcePolicy
      # PUT /bitstreams/{bitstream id}/data - Update data/file of bitstream. You must put the data
      # √ PUT /bitstreams/{bitstream id} - Update metadata of bitstream. You must put a Bitstream, does not alter the file/data
      # DELETE /bitstreams/{bitstream id} - Delete bitstream from DSpace.
      # DELETE /bitstreams/{bitstream id}/policy/{policy_id} - Delete bitstream policy.

      def get_bitstream_by_id(id, expand = nil)
        expand_uri = build_expand_uri(expand)
        response = rest_client["/bitstreams/#{id}?#{expand_uri}"].get
        DSpaceRest::Bitstream.new(JSON.parse(response))
      end

      def get_all_bitstreams(expand = nil, limit = nil, offset = nil)
        expand_uri = build_expand_uri(expand)
        limit_uri = build_parameter_uri('limit',limit)
        offset_uri = build_parameter_uri('offset',offset)
        response = rest_client["/bitstreams?#{expand_uri}&#{limit_uri}&#{offset_uri}"].get
        bit_streams = []
        JSON.parse(response).each do |bits|
          bit_streams << DSpaceRest::Bitstream.new(bits)
        end
        bit_streams
      end

      def retrieve_data(bitstream)
        response = rest_client["/bitstreams/#{bitstream.id}/retrieve"].get
      end

      def update(bitstream)
        valid_keys=[:name, :description, :sequenceId]
        form = JSON.generate(bitstream.to_h.select { |k, v| valid_keys.include? k })
        response = rest_client["/bitstreams/#{bitstream.id}"].put form
      end

      private

      def expandable_properties
        ["parent","policies","all"]
      end

      def query_parameters
        ["limit","offset"]
      end

    end
  end
end
