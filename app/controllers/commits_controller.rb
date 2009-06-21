class CommitsController < ApplicationController
  before_filter :find_repository

  ALLOWED_GROUPPING = %w(ticket_key ticket_status author_name)

  def index
    params[:reference] ||= Repository::DEFAULT_REFERENCE

    @commits = @repository.commits(params)
    if params[:get_ticket_status]
      @tracker = Tracker.new
      @tracker.update_commits(@commits)
    end

    respond_to do |format|
      
      group_by = params[:group_by]

      if ALLOWED_GROUPPING.include?(group_by)
        @grouped_commits = @commits.group_by { |c| c.send(group_by) }

        format.html do
          render :action => "index_by_#{group_by}" 
        end
      else
        format.html do
          render :action => "index" 
        end
      end

    end
  end

  protected

  def find_repository
    @repository = Repository.find(params[:repository_id])
  end
end
