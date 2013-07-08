require_relative 'twitter_require'

class User
  include Twitter

  attr_accessor :timeline

  def self.parse(json)
    User.new(JSON.parse(json)["screen_name"])
  end

  def self.parse_many(ids)
    url = Addressable::URI.new(:scheme => "https",
                           :host => "api.twitter.com",
                           :path => "1.1/users/lookup.json",
                           :query_values => {
                                 :user_id => ids.join(",")}).to_s
    results = TwitterSession.access_token("#{@user_name}.tcred").get(url).body
    results = JSON.parse(results)
      results.map{|result| User.new(result["screen_name"])}
  end


  def initialize(user_name)
    @user_name = user_name
  end

  def timeline
    results = get_twitter_data("statuses/user_timeline",
                                 screen_name: @user_name,
                                 count: 15)
    results.map do |result|
      user_stuff = Status.parse(result)
      Status.new(@user_name, *user_stuff)
    end
  end

  def followers
    results = get_twitter_data("followers/list", screen_name: @user_name)
    results["users"].map {|result| result["screen_name"]}
  end

  def followed_users
    results = get_twitter_data("friends/list", screen_name: @user_name)
    results["users"].map {|result| result["screen_name"]}
  end

end

if __FILE__ == $PROGRAM_NAME
  p User.new("mrdziuban").timeline
end