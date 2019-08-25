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

    fill_in "Text", with: "Is Ratbat a Decepticon?"
    fill_in "Description", with: Faker::Lorem.unique.paragraph(3)
    choose "question[question_type]", option: Rails.configuration.x.question_type.TRUE_FALSE
  end

  context "when successfully created" do
    it "can be seen on the questions list" do
      fill_in_choice(index: 0, text: "", truth_value: true)
      click_button "Create Question"

      expect(page).to have_content "Question was successfully created."
      expect(page).to have_content "Is Ratbat a Decepticon?"
    end
  end

  context "with more than one choice" do
    it "should display an error message", js: true do
      add_choice = find("a#add_choice")
      add_choice.click
      fill_in_choice(index: 0, text: "", truth_value: false)
      fill_in_choice(index: 1, text: "", truth_value: true)

      click_button "Create Question"
      expect(page).to have_content "True-False questions must have one and only one option"
    end
  end
end