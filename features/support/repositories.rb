require 'grit'

module RepositoryHelpers
  module_function

  def create_repo(name)
    Grit::Repo.init_bare( File.join(AppConfig.repos_root_dir, "#{name}.git") )
  end

  def destroy_repos
    FileUtils.rm_rf(AppConfig.repos_root_dir)
  end
end

World(RepositoryHelpers)

