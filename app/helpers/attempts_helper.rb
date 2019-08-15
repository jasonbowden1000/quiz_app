module AttemptsHelper
  def percent(n, d)
    d.nonzero? ? (n.to_f * 100 / d).round : 0
  end
  
  def status(finished, all)
    finished == all ? "Finished" : "In Progress"
  end
end
