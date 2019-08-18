class ProblemsController < ApplicationController
  before_action :authenticate_user!, :set_problem, :set_attempt

  def show
    redirect_to stats_path and return if @attempt.is_finished
    redirect_to attempt_problem_path(@attempt, @problem.succedent) unless @problem.current?
  end

  def update
    respond_to do |format|
      if @problem.update(problem_params)
        path = @problem.succedent ? attempt_problem_path(@attempt, @problem.succedent) : stats_path
        format.html { redirect_to path  }
      else
        format.html { render :show }
      end
    end
 end

  def problem_params
    params[:problem].present? ? params.require(:problem).permit(submitted_answer: []) : {submitted_answer: []}
  end

  def set_attempt
    @attempt = @problem.attempt
  end

  def set_problem
    @problem = Problem.find_by(attempt_id: params[:attempt_id], problem_order: params[:problem_order])
  end
end
