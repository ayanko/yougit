class Grit::Commit
  def merge?
    self.parents.size > 1
  end

  def color
    "#" + self.id[0,6]
  end

  def ticket
    @ticket ||= Ticket.for_commit(self)
  end

  def ticket_number
    ticket && ticket.number || "Unknown"
  end
  
  def ticket_key
    ticket && ticket.key || "Unknown"
  end
  
  def ticket_status
    ticket && ticket.status || "Unknown"
  end

  def author_name
    author.name
  end
  
  def tags
    @tags ||= @repo.tags.select { |t| t.commit.id == self.id }
  end
  
  def tag_names
    self.tags.map(&:name)
  end
end

class Commit < Grit::Commit

  LIST_LIMIT = 20

  def self.list(repository, options)
    opts = { 
      :pretty    => 'raw',
      :max_count => options[:limit]  || LIST_LIMIT,
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
