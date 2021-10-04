class BooksController < ApplicationController
  def new
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
      @books = Book.all
      flash[:error] = @book.errors.full_messages.count
      msg = @book.errors.full_messages.join(',')
      flash[:message] = msg.gsub(",","<br>")
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @newBook = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated.'

      @books = Book.all
      @newBook = Book.new
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
