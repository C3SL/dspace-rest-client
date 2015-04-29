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
      h = Hash.new
      h['id'] = @id
      h['action'] = @action
      h['epersonId'] = @eperson_id
      h['groupId'] = @group_id
      h['resourceId'] = @resource_id
      h['resourceType'] = @resource_type
      h['rpDescription'] = @rp_description
      h['rpName'] = @rp_name
      h['rpType'] = @rp_type
      h['startDate'] = @start_date
      h['endDate'] = @end_date
      h
    end

  end
end
