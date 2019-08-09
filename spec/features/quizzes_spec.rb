require "rails_helper"

RSpec.describe "Quizzes" do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user_with_quizzes, quizzes_count: 5 )}
  let!(:user3) { FactoryBot.create(:user_with_quizzes, quizzes_count: 7 )}
  # let!(:user4) { FactoryBot.create(:user, first_name: "Solus" )}
  # let!(:quiz2) { FactoryBot.create(:deck, title: "User 2 Quiz", user: user2) }
  # let!(:user3) { FactoryBot.create(:user_with_quizzes, user: user3 )}

  context "when created" do
    it "should be visible on the user's main quiz page" do
      login_as(user1)
      visit "/"
      click_link "Manage Quizzes"
      click_link "New Quiz"
      fill_in "Title", with: "Linux"
      fill_in "Description", with: "very useful knowledge"

      click_button "Create Quiz"

      expect(page.first("h2").text).to eql("Your Quizzes")
      expect(page).to have_content "Linux"
      expect(page).to have_content "very useful knowledge"
    end
  end

  context "when adding decks" do
    it "the user should be indicated when no decks are available"
    it "a user's decks should be visible from a menu"
    it "a user should not see decks from another user"
  end

  context "after adding decks" do
    it "display a deck list on their individual page"
      # A quiz should be ready
      # some decks should be ready
      # decks should be associated with quizzes
      # goto the quizzes page
  end

  context "when created" do
    it "should be visible on the user's main quiz page" do
      login_as(user1)
      visit "/"
      click_link "Manage Quizzes"
      click_link "New Quiz"
      fill_in "Title", with: "Linux"
      fill_in "Description", with: "very useful knowledge"

      click_button "Create Quiz"

      expect(page.first("h2").text).to eql("Your Quizzes")
      expect(page).to have_content "Linux"
      expect(page).to have_content "very useful knowledge"
    end
  end

  context "when adding decks" do
    it "the user should be indicated when no decks are available"
    it "a user's decks should be visible from a menu"
    it "a user should not see decks from another user"
  end

  context "after adding decks" do
    it "display a deck list on their individual page"
      # A quiz should be ready
      # some decks should be ready
      # decks should be associated with quizzes
      # goto the quizzes page
      # the decks should be there
  end

  context "when decks are removed" do
    it "do not hard delete actual decks"
    it "do not display deleted decks on their individual page"
    it "display undeleted decks on their individual page"
  end 

  context "when viewed" do
    it "should only be seen by their owner" do
      login_as(user2)
      visit quizzes_path

      expect(page).to have_selector('.quiz', count: user2.quizzes.length)

      logout
      login_as(user3)
      visit quizzes_path

      expect(page).to have_selector('.quiz', count: user3.quizzes.length)
    end
  end
end