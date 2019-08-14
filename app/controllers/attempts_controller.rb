class AttemptsController < ApplicationController
  before_action :authenticate_user!

  def create
    @attempt = current_user.attempts.build(quiz_id: attempts_params[:id])

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to attempt_problem_path(@attempt, @attempt.first_problem.problem_order) }
      else
        format.html { redirect_to quizzes_path, alert: "Could not create quiz." }
      end
    end
  end

  def index
    @attempts = current_user.attempts
  end

  def attempts_params
    params.require(:quiz).permit(:id)
  end
end