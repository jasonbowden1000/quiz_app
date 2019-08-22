class DecksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck, only: [:edit, :update, :destroy]

  def index
    @decks = current_user.active_decks
  end

  def new
    @deck = current_user.decks.build
  end

  def edit
  end

  def create
    @deck = current_user.decks.build(deck_params)

    respond_to do |format|
      if @deck.save
        format.html { redirect_to new_deck_question_path(@deck) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @deck.soft_delete
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
    end
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title, :description, questions: [])
  end
end
