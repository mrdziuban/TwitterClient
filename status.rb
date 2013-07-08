require_relative 'twitter_require'

class Status

  attr_accessor :text, :user

  def self.parse(parsed)
    text = parsed["text"]
    user_mentions = parsed["entities"]["user_mentions"].map do |user|
      User.new(user["screen_name"])
    end
    hashtags = parsed["entities"]["hashtags"]
    [text, user_mentions, hashtags]
  end

  def initialize(author, message, user_mentions = nil, hashtags = nil)
    @user = author
    @text = message
    @user_mentions = user_mentions
    @hashtags = hashtags.map {|hashtag| Hashtag.new(@user, hashtag["text"])}
  end

  def mentions
    @user_mentions
  end

  def hashtags
    @hashtags
  end

end