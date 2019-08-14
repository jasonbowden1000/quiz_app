class Attempt < ApplicationRecord
  after_create :populate_problems
  belongs_to :user
  belongs_to :quiz
  has_many :problems

  def status
    finished_problems.length == total_problems.length ? "Finished" : "In Progress"
  end

  private

  def finished_problems
    problems.where(answered: true)
  end

  def populate_problems
    quiz.questions.shuffle.each.with_index(1) do |q, i|
      Problem.create(order: i, attempt_id: id, question_id: q.id)
    end
  end

  def total_problems
    problems
  end
end