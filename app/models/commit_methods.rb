module CommitMethods
  def merge?
    self.parents.size > 1
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
end
