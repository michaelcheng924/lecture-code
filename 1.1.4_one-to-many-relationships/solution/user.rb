class User

  attr_reader :username, :tweets

  def initialize(username)
    @username = username

  # @tweets = [] # this is the idea that we will remove later
  end

  def tweets
    Tweet.all.select do |tweet|
      tweet.user == self
    end
  end

  def post_tweet(message)
    # create a new tweet
    tweet = Tweet.new(message, self)
  end

  # def post_tweet(message)
  #   # create a new tweet
  #   tweet = Tweet.new(message, self)
  #   # add that tweet to this users collection of tweets
  #   add_tweet(tweet)
  # end

  # private

  # def add_tweet(tweet)
  #   self.tweets << tweet
  # end
end