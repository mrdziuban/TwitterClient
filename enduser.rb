require_relative 'twitter_require'

class EndUser < User

  def self.set_user_name(user_name)
    @@current_user = EndUser.new(user_name)
  end

  def self.me
    @@current_user
  end

  def initialize(user_name)
    @user_name = user_name
  end

  def post_status(status_text)
    post_twitter_data("statuses/update", status: status_text)
  end

  def direct_message(other_user, text)
    post_twitter_data("direct_messages/new", screen_name: other_user, text: text)
  end

end

# p EndUser.new("mrdziuban").direct_message("appacademy123", "testing")