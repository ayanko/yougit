require 'grit'

module RepositoryHelpers
  module_function

  def create_repo(name)
    repo = Repository.create( File.join(AppConfig.repos_root_dir, "#{name}") )
  end

  def destroy_repos
    FileUtils.rm_rf(AppConfig.repos_root_dir) if AppConfig.repos_root_dir
  end

end

World(RepositoryHelpers)

