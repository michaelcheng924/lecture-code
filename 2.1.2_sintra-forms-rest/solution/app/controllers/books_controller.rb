class BooksController < ApplicationController
  
  get "/books" do
    @books = Book.all
    erb :"books/index"
  end

  get "/books/new" do
    erb :"books/new"
  end

  get "/books/:id" do
    @book = Book.find(params["id"])
    erb :"books/show"
  end

  post "/books" do
    Book.create(params)
    redirect "/books"
  end

  get "/books/:id/edit" do
    @book = Book.find(params["id"])
    erb :"/books/edit"
  end

  patch "/books/:id" do
    book = Book.find(params["id"])
    book.update(title: params["title"], snippet: params["snippet"])
    redirect "/books/#{book.id}"
  end

  delete "/books/:id" do
    Book.find(params["id"]).destroy
    redirect "/books"
  end
  
end
