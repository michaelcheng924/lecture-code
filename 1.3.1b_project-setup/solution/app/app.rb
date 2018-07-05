class Application
    def print_book(title, author, description)
      puts "*" * 30
      puts "Title: #{title}"
      puts "Author: #{author}"
      puts "Description: #{description}"
    end
  
  def run
    puts "Enter a search term."

    term = gets.chomp

    results = Adapter::GoogleBooks.new(term).fetch_books

    results.each do |book|
      title = book["title"]
      author = book["author"]
      description = book["description"]

      print_book(title, author, description)
    end
  end
end