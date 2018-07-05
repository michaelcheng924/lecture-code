results = Adapter::GoogleBooks.new('dogs').fetch_books

results.each do |result|
  Author.find_or_create_by(name: result["author"])
  Book.find_or_create_by(title: result["title"], author_id: Author.find_by(name: result["author"]).id)
end
