class Repository

  def initialize(path)
    @path = path
  end

  attr_reader :path

  def name
    @name ||= File.basename(self.path, ".git")
  end

  def repo
    @repo ||= Grit::Repo.new(self.path) 
  end

  def self.list
    Dir[File.join(AppConfig.repos_root_dir, "*")].map { |path| new(path) }
  end

end
