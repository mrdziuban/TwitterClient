require_relative 'twitter_require'

class Hashtag
  include Twitter

  attr_accessor :text

  def initialize(user_name, text)
    @user_name = user_name
    @text = text
  end

  def statuses
    results = get_twitter_data("search/tweets", q: "##{@text}")

    results["statuses"].map do |result|
      user_name = result["user"]["screen_name"]
      user_stuff = Status.parse(result)
      Status.new(user_name, *user_stuff)
    end
  end
end

Hashtag.new("mrdziuban", "ihatehashtags").statuses.each do |s|
  puts s.text, s.user
end