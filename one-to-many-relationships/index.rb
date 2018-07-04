class User

  attr_reader :username, :tweets

  def initialize(usernmae)
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
end

class Tweet
  attr_reader :message, :user

  @@all = []

  def initialize(message, user)
    @message = message
    @user = user

    @@all << self
  end

  def self.all
    @@all
  end
end

person = User.new('Michael')
person.post_tweet('new tweet')
puts person.tweets
puts Tweet.all
Tweet.all.delete_at(0)
puts "======"
puts person.tweets
puts Tweet.all
# puts Tweet.all
# puts person.tweets