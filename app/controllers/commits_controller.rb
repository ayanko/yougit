class CommitsController < ApplicationController
  before_filter :find_repository

  ALLOWED_GROUPPING = %w(ticket_key author_name)
  ALLOWED_PAR_PAGE = %w(20 30 50 100)

  def index
    params[:reference] ||= Repository::DEFAULT_REFERENCE
    params[:per_page] = ALLOWED_PAR_PAGE[0] unless ALLOWED_PAR_PAGE.include?(params[:per_page])

    @commits = Commit.paginate(@repository, {
      :per_page  => params[:per_page],
      :page      => params[:page] || 1,
    }, params)

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

  def find_repositories
    @repositories = Repository.list
  end

  def find_repository
    @repository = Repository.find(params[:repository_id])
  end
end
