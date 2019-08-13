class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:edit, :update, :destroy]

  def index
    @quizzes = current_user.quizzes
  end

  def new
    @quiz = current_user.quizzes.build
  end

  def edit
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quizzes_path, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quizzes_path, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz } # ?
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_quiz
      @quiz = current_user.quizzes.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description, deck_ids: [])
    end
end
