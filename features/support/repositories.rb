require 'grit'

module RepositoryHelpers
  module_function

  def repos_base_dir
    File.join(File.dirname(__FILE__), "..", "..", "tmp", "repositories")
  end

  def create_repo(name)
    Grit::Repo.init_bare( File.join(repos_base_dir, "#{name}.git") )
  end

  def destroy_repos
    FileUtils.rm_rf(repos_base_dir)
  end
end

World(RepositoryHelpers)

