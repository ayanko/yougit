class CommitsController < ApplicationController
  before_filter :find_repository

  def index
    @commits = @repository.commits(params)

    respond_to do |format|
      format.html 
    end
  end

  protected

  def find_repository
    @repository = Repository.find(params[:repository_id])
  end
end
