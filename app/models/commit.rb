class Commit < Grit::Commit

  def self.list(repository, options)
    opts = { 
      :pretty    => 'raw',
      :max_count => options[:limit]  || 100,
      :skip      => options[:offset] || 0
    }
    
    args = Array(options[:include_refs] || ["master"]) +
           ["--not"] + 
           Array(options[:exclude_refs] || [])

    output = repository.git.run("", "rev-list", "", opts, args)

    self.list_from_string(repository, output)
  end

end
