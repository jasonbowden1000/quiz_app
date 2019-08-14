class AttemptsController < ApplicationController
  before_action :authenticate_user!

  def create
    quiz = current_user.quizzes.find(params[:quiz][:id])

    attempt_params = {
      quiz_id: quiz.id,
      problems_attributes: quiz.questions.shuffle.each.with_index(1).map { |q, i| {
        question_id: q.id, order: i }
      }
    }

    @attempt = current_user.attempts.build(attempt_params)

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
end