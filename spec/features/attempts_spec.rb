require "rails_helper"

# I need
# quizzes with decks
# decks with questions
# questions with choices
# quizzes with attempts
# attempts with answers
# answers with choices
# all of this shit has a user

RSpec.describe "Attempts" do

=begin
  let!(:question1) { }
  let!(:question2) { }
  let!(:question3) { }

  let!(:deck1) { }
  let!(:deck2) { } 
  let!(:deck3) { }
  let!(:quiz1) { }
  let!(:quiz2) { }
  let!(:quiz3) { }
=end

  let!(:user1) { FactoryBot.create(:user_with_quizzes, quizzes_count: 3 )}

  describe "can be started by users" do
    it "by clicking the Take test button" do
      login_as(user1)
      visit quizzes_path
    end
  end

  describe "when beginning" do
    it "should display a Take Quiz button when untaken"
    it "should display a Continue Quiz button when in progress"
    it "should display a View Stats button when finished"
    it "should not display Take Quiz for quizzes where every deck is empty"
  end

  describe "taken by users" do
    it "should display a accurate correct/incorrect when finished"
    it "should return to the correct question when in progress"
    it "should not display previously answered questions"
    it "should not be viewed by other users"
  end
end
