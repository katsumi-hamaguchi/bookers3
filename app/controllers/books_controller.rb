class BooksController < ApplicationController


   before_action :authenticate_user!
   before_action :correct_book, only: [:edit, :update]
   
	def top
	end
		
	def index
  	 @book = Book.new
     @books = Book.all
     @user = current_user
     
  end

  def show
  	 @book = Book.find(params[:id])
     @newbook = Book.new
     @user = @book.user
  end


  def create
     @book = Book.new(book_params)

     @book.user_id = current_user.id

     if @book.save
     	flash[:notice] = "You have creatad book successfully."
     redirect_to book_path(@book.id)    
   else
       @books = Book.all
       @user = current_user
       render 'index'

     end 
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	book = Book.find(params[:id])
    if book.update(book_params)
     flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book.id)
      else
       @book = book
       render 'edit'
     end 
   end

  

  def destroy
  	book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
    def correct_book
      book = Book.find(params[:id])
      unless book.user == current_user
      redirect_to books_path
      end
    end
end
