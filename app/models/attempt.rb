class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :problems

  accepts_nested_attributes_for :problems

  def status
    finished_problems == total_problems ? "Finished" : "In Progress"
  end

  private

  def finished_problems
    problems.where(answered: true).length
  end

  def total_problems
    problems.length
  end
end