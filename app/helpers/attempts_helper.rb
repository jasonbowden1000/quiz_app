module AttemptsHelper
  def percent(n, d)
    d.nonzero? ? (n.to_f * 100 / d).round : 0
  end
  
  def status(is_finished)
    is_finished ? "Finished" : "In Progress"
  end
end
