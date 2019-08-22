require "rails_helper"

RSpec.describe "Decks" do
  let(:user1) { FactoryBot.create(:user) } 
  let!(:deck1) { FactoryBot.create(:deck_with_questions, user: user1) }
  let!(:deck2) { FactoryBot.create(:deck_with_questions, user: user1) }
  let!(:deck3) { FactoryBot.create(:deck_with_questions, user: user1) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, decks_count: 0, user: user1) }

  context "when removed" do
    it "should no longer be visible on a user's decks page", js: true do
      quiz1.decks << deck1 << deck2 << deck3 
      login_as(user1)
      visit decks_path
      decks = page.all("div.deck");
      initial_deck_count = decks.length
      within page.all("div.deck").first do
        page.accept_confirm do
          click_link "Delete"
        end
      end

      expect(page).to have_selector("div.deck", count: initial_deck_count - 1)
    end

    it "should no longer be visible when editing a quiz", js: true do
      quiz1.decks << deck1 << deck2 << deck3 
      login_as(user1)
      visit decks_path
      decks = page.all("div.deck");
      initial_deck_count = decks.length
      within decks.first do
        page.accept_confirm do
          click_link "Delete"
        end
      end

      visit edit_quiz_path(quiz1);
      expect(page).to have_selector(".deck_check_box", count: initial_deck_count - 1)
    end

    it "should not impact existing quiz attempts", js: true do
      quiz1.decks << deck1
      title = quiz1.title
      deck_id = deck1.id
      login_as(user1)
      visit quizzes_path
      within("div#quiz_#{quiz1.id}") do
        click_button "Take Quiz"
      end

      attempt_id = current_path.split("/")[2]
      choose("choice_1")
      click_button "Submit Answer"

      visit decks_path

      within("div#deck_#{deck_id}") do
        page.accept_confirm do
          click_link "Delete"
        end
      end

      visit stats_path
      click_link title
      expect(page.current_path).to eql(attempt_problem_path(attempt_id, 2))
    end
  end
end