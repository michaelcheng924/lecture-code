class Tweet
  attr_accessor :message, :username
  ALL = []

  def self.all
    sql = <<-SQL
    SELECT * FROM tweets
    SQL

    DB[:conn].execute(sql).map do |tweet|
      Tweet.new(tweet)
    end
  end

  def initialize(props={})
    @message = props['message']
    @username = props['username']

    @id = props['id']

    ALL << self
  end

  def save
    if(@id)
      sql = <<-SQL
      UPDATE tweets
      SET message = ?
      WHERE id = ?
      SQL

      DB[:conn].execute(sql, @message, @id)
    else
      sql = <<-SQL
      INSERT INTO tweets (username, message)
      VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, @username, @message)
    end
  end

  def self.create(props={})
    new_tweet = Tweet.new(props)
    new_tweet.save
  end
end
