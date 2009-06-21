class Grit::Commit
  def merge?
    self.parents.size > 1
  end

  def color
    "#" + self.id[0,6]
  end

  def ticket
    @ticket ||= self.short_message.scan(/^([A-Z]+-[0-9]+):/i).flatten.first
  end
end

class Commit < Grit::Commit

  def self.list(repository, options)
    opts = { 
      :pretty    => 'raw',
      :max_count => options[:limit]  || 100,
      :skip      => options[:offset] || 0
    }
    opts.merge!(:no_merges => true) if options[:no_merges] == '1'
    
    args = []
    args << (options[:reference] || "master")
    args += Array(options[:include]) unless options[:include].blank?
    args += ["--not"] + Array(options[:exclude]) unless options[:exclude].blank?

    output = repository.git.run("", "rev-list", "", opts, args)

    self.list_from_string(repository, output)
  end

end
