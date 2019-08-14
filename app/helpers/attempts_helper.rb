module AttemptsHelper
  def percent(n, d)
    (n.to_f * 100 / d).round
  end
  
  def status(finished, all)
    finished == all ? "Finished" : "In Progress"
  end
end
