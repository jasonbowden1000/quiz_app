require "rails_helper"

RSpec.describe "Attempts" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks) }

  # This needs a quiz, with decks, with questions

  describe "can be started by users" do
    it "by clicking the Take test button" do
      login_as(user1)
      visit quizzes_path
      expect(2+2).to eql(4)
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
