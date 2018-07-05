class User < ActiveRecord::Base
  has_many :likes
  has_many :tweets, through: :likes
end