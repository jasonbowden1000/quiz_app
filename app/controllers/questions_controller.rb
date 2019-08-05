class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck

  def index
    @questions = @deck.questions
  end

  def new
    @question = Question.new
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
end
