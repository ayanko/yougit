require 'jira4r'

class Tracker

  STATUS_NAME_BY_CODE = {
    "1" => "Open",
    "3" => "InProgress",
    "4" => "Reopened",
    "5" => "Resolved",
    "6" => "Closed"
  }

  def initialize
    @logger = Logger.new(STDERR)
    @logger.level = Logger::INFO

    @jira = Jira4R::JiraTool.new(2, AppConfig.tracker['url'])
    @jira.logger = @logger

    login
  end

  def login
    @jira.login(AppConfig.tracker['login'], AppConfig.tracker['password'])
  end

  def update_commits(commits)
    update_tickets(Array(commits).map(&:ticket).compact)
  end

  def update_tickets(tickets)
   threads = []

   Array(tickets).each do |ticket|
     threads << Thread.new(ticket) do |t|
       begin
         issue = @jira.getIssue(t.key)
         update_ticket_from_issue(t, issue)
       rescue SOAP::FaultError => e
         @logger.error("#{e.class.name}: #{e.message}")
       end
     end
   end

   threads.each { |thread| thread.join }
  end
 
  protected

  def update_ticket_from_issue(ticket, issue)
    return unless issue
    ticket.status = STATUS_NAME_BY_CODE[issue.status] || "Unknown"
  end
end
