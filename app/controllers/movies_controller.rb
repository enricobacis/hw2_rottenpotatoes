class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @order = params[:order] if Movie.column_names.include? params[:order]
    @ratings = params[:ratings].select{|k,v| v == "1"} unless params[:ratings].nil?
    if @order.nil? && @ratings.nil?
      if !session[:order].nil? || !session[:ratings].nil?
        flash.keep
        return redirect_to movies_path, :order => session[:order], :ratings => session[:ratings]
      end
    end
    session[:order] = @order ; session[:ratings] = @ratings
    rating_keys = @ratings.keys unless @ratings.nil?
    @movies = Movie.find(:all, :conditions => {:rating => rating_keys}, :order => @order)
    @all_ratings = Movie.all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
