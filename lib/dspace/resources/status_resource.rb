module Dspace
  module Resources
    class StatusResource < ResourceKit::Resource

      resources do

        action :test, 'GET /rest/test' do
          handler(200, 201) { |response| true }
        end

        action :status, 'GET /rest/status' do
          handler(200) { |response| JSON.parse(response.body) }
        end

      end
      
    end
  end
end