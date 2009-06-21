class Ticket
  @@url_template = ERB.new("http://jira.ratepoint.com/jira/browse/<%= key %>")

  @@prefix_pattern  = '^'
  @@project_pattern = '([A-Za-z]+)'
  @@spliter_pattern = '(-)'
  @@number_pattern  = '([0-9]+)'
  @@suffix_pattern  = ':'

  def self.pattern
    @pattern ||= Regexp.new(
      @@prefix_pattern  +
      @@project_pattern +
      @@spliter_pattern + 
      @@number_pattern  + 
      @@suffix_pattern
    )
  end

  def self.for_commit(commit)
    new($1, $3, $2) if self.pattern.match(commit.short_message)
  end

  def self.tracker
    @tracker ||= Tracker.new
  end

  def self.update_status(tickets)
  end

  def initialize(project, number, separator)
    @project   = project
    @number    = number
    @separator = separator
  end

  attr_reader :project, :number, :separator
  attr_accessor :status

  def key
    "#{project}#{separator}#{number}"
  end

  def url
    @url ||= @@url_template.result(binding)
  end

end
