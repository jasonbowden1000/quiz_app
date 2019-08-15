class ProblemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_problem

  def show
    @attempt = Attempt.find(params[:attempt_id])
    # Bounce the user if problem is not current problem
  end

  def update
    respond_to do |format|
      if @problem.update(problem_params)
        path = @problem.next ? attempt_problem_path(@problem.attempt, @problem.next) : stats_path
        format.html { redirect_to path  }
      else
        @attempt = @problem.attempt
        format.html { render :show }
      end
    end
 end

  def problem_params
    params.require(:problem).permit(:submitted_answer)
  end

  def set_problem
    @problem = Problem.find_by(attempt_id: params[:attempt_id], problem_order: params[:problem_order])
  end
end
