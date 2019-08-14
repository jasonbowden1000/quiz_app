class AttemptsController < ApplicationController
  before_action :authenticate_user!

  def create
    @attempt = current_user.attempts.build(quiz_id: attempts_params[:id])

    respond_to do |format|
      if @attempt.save
        first_problem = Problem.find_by(order: 1, attempt_id: @attempt.id)
        format.html { redirect_to attempt_problem_path(@attempt, first_problem) }
      else
        Rails.logger.info "ATTEMPT DID NOT SAVE PROPERLY"
        # You have to go back
        # goto quizzes page, display a notice
        Rails.logger.info @attempt.errors
        # format.html { render :new }
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