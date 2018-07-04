require 'pry'
require 'rest-client'
require 'json'


# write an application that takes in some user input
def welcome
  puts "Welcome to the BookSearcher"
  puts "Please enter a term:"
end

def get_user_input
  gets.chomp
end


# make a request to the google books api using term

def fetch_books(term)
  response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{term}")

  JSON.parse(response.body)
end


def get_title(book)
 title = book["volumeInfo"]["title"]
end

def get_author(book)
  if  book["volumeInfo"]["authors"]
   book["volumeInfo"]["authors"].join(" and ")
  else
   "No authors found"
  end
end

def get_description(book)
  if  book["volumeInfo"]["description"]
    book["volumeInfo"]["description"][0..140] + "..."
  else
    "No description available"
  end
end

def print_book(title, authors, description)
  puts "*" * 30
  puts "Title: #{title}"
  puts "Authors: #{authors}"
  puts "Description: #{description}"
end


def run
  welcome
  search_term = get_user_input
  fetch_books(search_term)["items"].each do |book|
    title = get_title(book)
    authors = get_author(book)
    description = get_description(book)

    print_book(title, authors, description)
  end
end

# and display a list of books, including title, author and description, that are found
run
