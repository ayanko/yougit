class Repository < Grit::Repo
  
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
    new(File.join(AppConfig.repos_root_dir, "#{id}"))
  end

  def name
    @name ||= self.bare ? 
      File.basename(self.path, ".git") : 
      File.basename(self.working_dir) 
  end
  
  def create_empty_commit(message)
    git.run("", "commit", "", { :allow_empty => true, :m => message }, [])
  end

  def create_branch(name, start_point=nil)
    git.run("", "branch", "", {}, [name, start_point.to_s])
  end


  def commits(options = {})
    Commit.list(self, options)
  end

end
