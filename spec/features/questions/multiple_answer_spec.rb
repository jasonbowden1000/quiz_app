require "rails_helper"

RSpec.describe "New Multiple-Answer questions" do
  let(:user1) { FactoryBot.create(:user) }
  let!(:deck1) { FactoryBot.create(:deck, user: user1 )}

  before do
    login_as(user1)
    visit decks_path

    within("div#deck_#{deck1.id}") do
      click_link "Manage Questions"
    end

    click_link "Add Question"

    fill_in "Text", with: "Who is a Decepticon?"
    fill_in "Description", with: "Check all that apply"
    choose "question[question_type]", option: Rails.configuration.x.question_type.MULTIPLE_ANSWER
  end

  context "when successfully created" do
    it "can be seen on the questions list", js: true do
      add_choice = find("a#add_choice")
      3.times { add_choice.click }
      fill_in_choice(index: 0, text: "Omega Supreme", truth_value: false)
      fill_in_choice(index: 1, text: "Astrotrain", truth_value: true)
      fill_in_choice(index: 2, text: "Ultra Magnus", truth_value: false)
      fill_in_choice(index: 3, text: "Scorponok", truth_value: true)

      click_button "Create Question"

      expect(page).to have_content "Question was successfully created."
      expect(page).to have_content "Who is a Decepticon?"
    end
  end

  context "without at least two choices" do
    it "should display an error message" do
      fill_in_choice(index: 0, text: "Thunderwing", truth_value: false)

      click_button "Create Question"

      expect(page).to have_content "Multiple answer questions must have at least two choices"
    end
  end
end