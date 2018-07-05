require_relative "../program.rb"

describe "is_palindrome?" do

  it "should work for racecar" do
    expect(is_palindrome?("racecar")).to be(true)
  end

  it "should ignore spaces and capitals" do
    expect(is_palindrome?("rAce car")).to be(true)
  end

  it "should ignore punctuation" do
    expect(is_palindrome?("racecar!!")).to be(true)
  end

  it "should raise an error if the input is a number" do
    expect { is_palindrome?(2) }.to raise_error(ArgumentError)
  end

end
