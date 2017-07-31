class AthleteDecorator < Draper::Decorator
  delegate_all

  STRAVA_URL = 'https://www.strava.com'.freeze
  MAX_INFO_TEXT_LENGTH = 25

  def profile_url
    if object.id.blank?
      STRAVA_URL
    else
      "#{STRAVA_URL}/athletes/#{object.id}"
    end
  end

  def profile_image_url
    object.profile if valid_url?(object.profile)
  end

  def following_url
    if object.id.blank?
      STRAVA_URL
    else
      "#{profile_url}/follows?type=following"
    end
  end

  def follower_url
    if object.id.blank?
      STRAVA_URL
    else
      "#{profile_url}/follows?type=followers"
    end
  end

  def fullname
    if object.firstname.blank? && object.lastname.blank?
      'Strava User'
    else
      "#{object.firstname} #{object.lastname}".to_s.strip
    end
  end

  def display_name
    return fullname unless fullname.length > MAX_INFO_TEXT_LENGTH
    return object.firstname unless object.firstname.blank?
    return object.lastname unless object.lastname.blank?
  end

  def location # rubocop:disable AbcSize, CyclomaticComplexity, PerceivedComplexity
    return '' if object.city.nil? && object.country.nil?
    return object.country.name.to_s.strip if object.city.nil?
    return object.city.name.to_s.strip if object.country.nil?

    return '' if object.city.name.blank? && object.country.name.blank?
    return object.country.name.to_s.strip if object.city.name.blank?
    return object.city.name.to_s.strip if object.country.name.blank?
    "#{object.city.name.to_s.strip}, #{object.country.name.to_s.strip}"
  end

  def display_location
    return location unless location.length > MAX_INFO_TEXT_LENGTH
    return object.city.name unless object.city.nil? || object.city.name.blank?
    return object.country.name unless object.country.nil? || object.country.name.blank?
  end

  def friend_count
    if object.friend_count.blank?
      '0'
    else
      object.friend_count.to_s.strip
    end
  end

  def follower_count
    if object.follower_count.blank?
      '0'
    else
      object.follower_count.to_s.strip
    end
  end

  def heart_rate_zones
    ApplicationHelper::Helper.get_heart_rate_zones(object.id)
  end

  private

  def valid_url?(string)
    uri = URI.parse(string)
    %w[http https ftp].include?(uri.scheme)
  rescue URI::InvalidURIError
    false
  end
end
