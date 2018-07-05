def is_palindrome?(word)
  if(!word.is_a?(String))
    raise ArgumentError
  end

  modified_word = word.downcase.gsub(" ", "").gsub(/[^a-zA-Z]/, '')
  modified_word == modified_word.reverse
end
