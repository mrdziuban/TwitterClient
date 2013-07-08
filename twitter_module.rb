require_relative 'twitter_require'

module Twitter

  def get_twitter_data(path, options = {})
    url = Addressable::URI.new(:scheme => "https",
                         :host => "api.twitter.com",
                         :path => "1.1/#{path}.json",
                         :query_values => options).to_s
                         p url
    results = TwitterSession.access_token("#{@user_name}.tcred").get(url).body
    JSON.parse(results)
  end

  def post_twitter_data(path, options = {})
    url = Addressable::URI.new(:scheme => "https",
                         :host => "api.twitter.com",
                         :path => "1.1/#{path}.json",
                         :query_values => options).to_s
    TwitterSession.access_token("#{@user_name}.tcred").post(url).body
  end

end