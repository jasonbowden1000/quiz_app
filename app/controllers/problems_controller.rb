class ProblemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_problem

  def show
    @attempt = Attempt.find(params[:attempt_id])
    # Bounce the user if problem is not current problem
  end

  def update
    is_correct = @problem.correct_choice.id == problem_params[:answer].to_i

    # we should also check for a submission, that is, problem_params[:answer] should have a value
    # something like rescue from ActionController::ParameterMissing
    respond_to do |format|
      if @problem.update({answered: true, correct: is_correct })
        next_problem = @problem.next
        path = next_problem ? attempt_problem_path(@problem.attempt, next_problem) : attempts_path
        format.html { redirect_to path  }
      else
        Rails.logger.info "Something went wrong"
        # format.html { render :edit }
      end
    end
 end

  def problem_params
    params.require(:problem).permit(:answer)
  end

  def set_problem
    @problem = Problem.find_by(attempt_id: params[:attempt_id], problem_order: params[:problem_order])
  end
end
