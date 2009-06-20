require 'grit'

module RepositoryHelpers
  module_function

  def create_repo(name)
    repo = Grit::Repo.init( File.join(AppConfig.repos_root_dir, "#{name}.git") )
  end

  def destroy_repos
    FileUtils.rm_rf(AppConfig.repos_root_dir) if AppConfig.repos_root_dir
  end

end

World(RepositoryHelpers)

