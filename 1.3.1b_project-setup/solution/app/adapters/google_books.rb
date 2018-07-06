module GoogleBooks
  class Adapter
    attr_reader :term

    def initialize(term)
      @term = term
    end

    def fetch_books
      results = JSON.parse(RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{@term}"))["items"]

      results.map do |result|
        {
          "title" => result["volumeInfo"]["title"],
          "author" => result["volumeInfo"]["authors"] ? result["volumeInfo"]["authors"][0] : "None",
          "description" => result["volumeInfo"]["description"],
        }
      end
    end
  end
end