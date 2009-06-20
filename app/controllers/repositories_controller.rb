class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.list

    respond_to do |format|
      format.html 
    end
  end
end
