require "rails_helper"

RSpec.describe "Quizzes" do
  let!(:user_without_decks) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user_with_quizzes, quizzes_count: 3 )}
  let!(:user3) { FactoryBot.create(:user_with_quizzes, quizzes_count: 5 )}
  let!(:user4) { FactoryBot.create(:user_with_decks, decks_count: 3 )}

  context "when created" do
    before do
      login_as(user4) 
      @odd_decks, @even_decks = user4.decks.partition.each_with_index { |d, i| i.odd? }

      visit "/"
      click_link "Manage Quizzes"
      click_link "New Quiz"
      fill_in "Title", with: "Linux"
      fill_in "Description", with: "very useful knowledge"
      @odd_decks.each { |deck| check("quiz_deck_ids_#{deck.id}") }
      click_button "Create Quiz"
    end

    it "should be visible on the user's main quiz page" do
      expect(page.first("h2").text).to eql("Your Quizzes")
      expect(page).to have_content "Linux"
      expect(page).to have_content "very useful knowledge"
    end

    it "should display selected decks content" do
      @odd_decks.each { |deck| expect(page).to have_content deck.title }
      @even_decks.each { |deck| expect(page).not_to have_content deck.title }
    end
  end

  context "when adding decks" do
    it "the user should be indicated when no decks are available" do
      login_as(user_without_decks)
      visit "/"
      click_link "Manage Quizzes"

      click_link "New Quiz"

      expect(page).not_to have_selector("input[type=submit][value='Create Quiz']")
      expect(page).to have_content "You have no decks. Create a deck first"
      expect(page).to have_link(href: decks_path)
    end

    it "a user should not see decks from another user" do
      login_as(user4)
      visit "/"
      click_link "Manage Quizzes"

      click_link "New Quiz"

      expect(page).to have_selector(".deck_check_box", count: user4.decks.length)
    end
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