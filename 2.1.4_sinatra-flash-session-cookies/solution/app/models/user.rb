require 'bcrypt'

class User < ActiveRecord::Base
  def password
    BCrypt::Password.new(password_digest)
  end
  
  def password=(new_password)
    password = BCrypt::Password.create(new_password)
    self.password_digest = password
  end
end