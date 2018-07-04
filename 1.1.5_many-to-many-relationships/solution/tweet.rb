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

  def likes
    Like.all.select do |like|
      like.tweet == self
    end
  end

  def likers
    likes.map do |like|
      like.user
    end
  end
end