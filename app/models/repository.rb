class Repository < Grit::Repo

  DEFAULT_REFERENCE = 'master'
  
  # Implement repo creation
  def self.create(path)
    path = File.join(path, '.git')

    git = Grit::Git.new(path)
    git.init({})
    git.commit({
      :allow_empty => true,
      :m => "Initialized"
    })

    self.new(path)
  end

  def self.list
    Dir[File.join(AppConfig.repos_root_dir, "*")].select { 
      |f| File.directory?(f) 
    }.map { |path| 
      begin
        new(path)
      rescue Grit::InvalidGitRepositoryError
      end
    }.compact
  end

  def self.find(id)
    path = File.join(AppConfig.repos_root_dir, "#{id}")
    new(File.exists?(path) ? path : "#{path}.git")
  end

  def name
    @name ||= self.bare ? 
      File.basename(self.path, ".git") : 
      File.basename(self.working_dir) 
  end
 
  alias :to_param :name
  
  def create_empty_commit(message)
    git.run("", "commit", "", { :allow_empty => true, :m => message }, [])
  end

  def create_branch(name, start_point=nil)
    git.run("", "branch", "", {}, [name, start_point.to_s])
  end


  def commits(options = {})
    Commit.list(self, options)
  end
  
  def paginate(options = {})
    Commit.paginate(self, options)
  end

  def heads
    Head.find_all(self).sort_by(&:name)
  end

end
