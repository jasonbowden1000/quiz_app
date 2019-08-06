class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck

  def create
    Rails.logger.info question_params

    @question = @deck.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to deck_questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        Rails.logger.info "there were errors, bummer"
        Rails.logger.info @question.errors
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @questions = @deck.questions
  end

  def new
    @question = @deck.questions.build
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def question_params
    params.require(:question).permit(:text, :description, :question_type, answers_attributes: [:text, :truth_value, :id])
  end
end
