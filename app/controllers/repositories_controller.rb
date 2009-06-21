class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.list.sort_by(&:name)

    respond_to do |format|
      format.html 
    end
  end

  def show
    @repository = Repository.find(params[:id])

    respond_to do |format|
      format.html 
    end
  end

end
