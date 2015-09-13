class SearchController < ApplicationController
  def query
    @records = Movie.search(params[:search], index_name: [Movie.searchkick_index.name]).results

    if @records.length == 1
      redirect_to @records.first
      return
    end

    respond_to do |format|
      format.html # query.html.erb
      format.json { render json: @records }
    end
  end
end
