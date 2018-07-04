class User

  attr_reader :username, :tweets

  def initialize(username)
    @username = username
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

  def like_tweet(tweet)
    Like.new(self, tweet)
  end

  def likes
    Like.all.select do |like|
      like.user == self
    end
  end

  def liked_tweets
    likes.map do |like|
      like.tweet
    end
  end
end