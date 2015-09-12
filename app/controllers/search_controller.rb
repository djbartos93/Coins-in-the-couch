class SearchController < ApplicationController
def query
    @records = Movie.search "*"
    @records.each do |record|
      puts record
    end
    if @records.length == 1
      redirect_to @records.first
      return
    end
      respond_to do |format|
        format.html
        format.json {render json: @records}
    end
  end
end
