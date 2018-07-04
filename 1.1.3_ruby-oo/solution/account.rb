require "pry"

class BankAccount
  attr_reader :user_id, :balance

  @@all = []

  def initialize(user_id, balance)
    @user_id = user_id
    @balance = balance

    @@all << self
  end

  def deposit(amount)
    @balance = @balance+amount
  end

  def withdraw(amount)
    @balance = @balance-amount
  end

  def self.all
    @@all
  end
end