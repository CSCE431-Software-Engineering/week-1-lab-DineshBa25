class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to books_path, alert: 'Book not found.'
    end
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to books_path, alert: 'Book not found.'
    elsif @book.update(book_params)
      redirect_to books_path, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @book = Book.find_by(id: params[:id])
    redirect_to books_path, alert: 'Book not found.' if @book.nil?
  end
  
  def delete
    @book = Book.find_by(id: params[:id])
    redirect_to books_path, alert: 'Book not found.' if @book.nil?
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book
      @book.destroy
      flash[:notice] = 'Book was successfully deleted.'
    else
      flash[:alert] = 'Book not found.'
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end
end
