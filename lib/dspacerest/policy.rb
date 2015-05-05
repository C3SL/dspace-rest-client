module DSpaceRest
  class Policy

    attr_reader :id, :action, :eperson_id, :group_id,
                :resource_id, :resource_type, :rp_description,
                :rp_name, :rp_type, :start_date, :end_date

    def initialize args
      @id = args['id']
      @action = args['action']
      @eperson_id = args['epersonId']
      @group_id = args['groupId']
      @resource_id = args['resourceId']
      @resource_type = args['resourceType']
      @rp_description = args['rpDescription']
      @rp_name = args['rpName']
      @rp_type = args['rpType']
      @start_date = args['startDate']
      @end_date = args['endDate']
    end

    def to_h
      h = {
          id: @id,
          action: @action,
          epersonId: @eperson_id,
          groupId: @group_id,
          resourceId: @resource_id,
          resourceType: @resource_type,
          rpDescription: @rp_description,
          rpName: @rp_name,
          rpType: @rp_type,
          startDate: @start_date,
          endDate: @end_date
      }
      
      h
    end

  end
end
