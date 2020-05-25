module Dspace
  module Adapter
    class NetHttpPersistent < Faraday::Adapter::NetHttpPersistent
      
      # Override empty close method from Faraday's NetHttpPersistent Adapter,
      # calling the shutdown method from Net::HTTP::Persistent gem to close 
      # open connections
      def close
        @cached_connection.shutdown unless @cached_connection.nil?
      end

    end
  end
end