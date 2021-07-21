class Admin::GenresController < ApplicationController
  def index
    @genre=Genre.new
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      flash[:info] = '登録に成功しました。'
      redirect_to admin_genres_path
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:info] = '登録に成功しました。'
      redirect_to admin_genres_path
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
