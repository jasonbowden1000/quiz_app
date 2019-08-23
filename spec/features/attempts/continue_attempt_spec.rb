require "rails_helper"

RSpec.describe "Incomplete attempts" do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, user: user1, title: "somequiz") }

  def begin_quiz
    login_as(user1)
    visit quizzes_path
    within("div#quiz_#{quiz1.id}") do
      click_button "Take Quiz"
    end
  end

  context "from the stats page" do
    it "can be continued by users" do
      begin_quiz
      attempt_id = current_path.split("/")[2]

      choose("choice_1")
      click_button "Submit Answer"
      visit stats_path
      click_link quiz1.title

      expect(page.current_path).to eql(attempt_problem_path(attempt_id, 2))
    end

    it "do not show percent correct" do
      begin_quiz
      attempt_id = current_path.split("/")[2]
      choose("choice_1")
      click_button "Submit Answer"
      visit stats_path
      attempt = find_by_id("attempt_#{attempt_id}")
      expect(attempt).not_to have_content "100%"
      expect(attempt).not_to have_content "1/1"
    end
  end
end