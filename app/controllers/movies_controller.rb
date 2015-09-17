class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direciton
  LOGGER = true
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.order(sort_column + " " + sort_direciton)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def sync

    url = "http://#{Settings.ip_addr}:5050/api/#{Settings.api_key}/movie.list"
    print url
    print "movie sync in progress"
    uri = URI.parse(url)


    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    output = JSON.parse response.body
    output['movies'].compact.each do |movie_info|
      debug_sync
      Movie.find_or_create_by(:imdb_id => movie_info['info']['imdb']).update(:title => movie_info['info']['original_title'],
      :director => movie_info['info']['directors'],
      :genre => movie_info['info']['genres'],
      :year => movie_info['info']['year'],
      :quality => movie_info['releases'].empty? ? "None" : movie_info['releases'][0]['quality'],
      :imdb_id => movie_info['info']['imdb'],
      :mpaa => movie_info['info']['mpaa'])
    end
  end




  private
  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  def sort_direciton
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :director, :genre, :year, :quality)
    end
end
def debug_sync
  print movie_info['info']['original_title'].to_yaml
  print movie_info['info']['directors'].to_yaml
  print movie_info['info']['genres'].to_yaml
  print movie_info['info']['year'].to_yaml
  print movie_info['info']['mpaa'].to_yaml
end
