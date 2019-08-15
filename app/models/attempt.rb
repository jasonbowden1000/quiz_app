class Attempt < ApplicationRecord
  after_create :populate_problems
  belongs_to :user
  belongs_to :quiz
  has_many :problems

  delegate :title, to: :quiz

  def correct_problems
    problems.correct
  end

  def finished_problems
    problems.finished
  end

  def is_finished
    finished_problems.length == problems.length
  end

  def first_problem
    problems.first_problem
  end

  private

  def populate_problems
    quiz.questions.shuffle.each.with_index(1) do |q, i|
      problems.build(problem_order: i, question_id: q.id)
    end
  end
end