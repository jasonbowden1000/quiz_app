class Attempt < ApplicationRecord
  after_create :populate_problems
  belongs_to :user
  belongs_to :quiz
  has_many :problems

  delegate :title, to: :quiz

  def first_problem
    problems.where(problem_order: 1).first
  end

  def status
    problems.length == finished_problems.length ? "Finished" : "In Progress"
  end

  private

  def finished_problems
    problems.select(&:answered?)
  end

  def populate_problems
    quiz.questions.shuffle.each.with_index(1) do |q, i|
      problems.create(problem_order: i, question_id: q.id)
    end
  end
end