class Head < Grit::Head
  def to_param
    self.name
  end
end
