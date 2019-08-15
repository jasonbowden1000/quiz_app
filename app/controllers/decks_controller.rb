class DecksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks
  end

  def show
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
        format.html { redirect_to @deck }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
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
