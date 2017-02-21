class ActivityFetcher
  def initialize(access_token)
    if access_token.blank?
      raise ArgumentError, 'ActivityFetcher - Blank access token was passed in.'
    end
    @access_token = access_token
    @api_wrapper = StravaApiWrapper.new(@access_token)
  end

  def fetch_all(options = {})
    mode = options[:mode] || 'latest'
    type = options[:type] || %w(best-efforts races)

    begin
      # Create or update the current athlete first.
      current_athlete_json = @api_wrapper.retrieve_current_athlete
      athlete = Creators::AthleteCreator.create_or_update(current_athlete_json, @access_token)

      # Retrieve activities of the current athlete.
      activities_to_retrieve = []
      activity_ids = get_all_activity_ids(type)
      activity_ids.sort.each do |activity_id|
        if (mode == 'all') || athlete.last_activity_retrieved.blank?
          activities_to_retrieve << activity_id
        else
          activities_to_retrieve << activity_id if activity_id > athlete.last_activity_retrieved
        end
      end

      Rails.logger.info("ActivityFetcher - Total number of #{activities_to_retrieve.count} activities to be retrieved for athlete #{athlete.id}.")
      activities_to_retrieve.sort.each do |activity_id|
        activity = @api_wrapper.retrieve_an_activity(activity_id)
        Creators::ActivityCreator.create_or_update(activity)
        athlete.last_activity_retrieved = activity_id
        athlete.save!
      end
    rescue Exception => e
      Rails.logger.error("ActivityFetcher - Error fetching athlete information with access_token '#{@access_token}'.\n\tMessage: #{e.message}\nBacktrace:\n\t#{e.backtrace.join("\n\t")}")
    end
  end

  private

  # Get ids of all running activities that have achievement items or are races.
  def get_all_activity_ids(type)
    # Call Strava API to list all athlete activities,
    # then parse out all activity ids.
    athlete_activities = @api_wrapper.list_all_athlete_activities

    # For all activity ids, choose running activities only,
    # then select those without achievement items or have workout_type of race.
    activity_ids = []
    athlete_activities.each do |page|
      page.each do |activity|
        activity_json = JSON.parse(activity.to_json)
        next unless activity_json['type'] == 'Run'
        if type.include?('best-efforts') and activity_json['achievement_count'] > 0
          activity_ids << activity_json['id']
        end
        if type.include?('races') and activity_json['workout_type'] == 1
          activity_ids << activity_json['id']
        end
      end
    end
    activity_ids.uniq!
    activity_ids
  end
end