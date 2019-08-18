require "rails_helper"

RSpec.describe "New Multiple-Choice Questions" do
  let(:user1) { FactoryBot.create(:user) }
  let!(:deck1) { FactoryBot.create(:deck, user: user1 )}

  def fill_in_choice(index:, text:, truth_value:)
    fill_in "choice_text_#{index}", with: text
    choose "choice_#{truth_value}_#{index}", option: truth_value
  end

  def setup_question
    fill_in "Text", with: "Who's on first?"
    fill_in "Description", with: "This test will build your critical thinking ability"
    choose "question[question_type]", option: Rails.configuration.x.question_type.multiple_choice
  end

  before do
    login_as(user1)
    visit decks_path
    within("div#deck_#{deck1.id}") do
      click_link "Manage Questions"
    end

    click_link "Add Question"
  end

  context "submitted with missing question text fields" do
    it "should display an error message", js: true do
      add_choice = find("a#add_choice")
      add_choice.click
      fill_in_choice(index: 0, text: "Hu", truth_value: false)
      choose "question[choices_attributes][1][truth_value]", option: true
      click_button "Create Question"

      expect(page).to have_content "Text can't be blank" 
    end

    it "should persist submitted data in dynamically generated fields", js: true do
      add_choice = find("a#add_choice")
      3.times { add_choice.click }
      fill_in_choice(index: 0, text: "Hu", truth_value: true)
      fill_in_choice(index: 1, text: "Who", truth_value: true)
      fill_in_choice(index: 2, text: "Scooby Doo", truth_value: false)
      fill_in_choice(index: 3, text: "The Fonz", truth_value: false)

      click_button "Create Question"

      expect(page.all(".choice").count).to eql(4)
      expect(page).to have_selector("input[value='The Fonz'")
      expect(find("#choice_true_1")).to be_checked
      expect(find("#choice_false_2")).to be_checked
    end
  end

  context "submitted with missing description fields" do
    it "should display an error message" do
      click_button "Create Question"
      expect(page).to have_content "Description can't be blank"
    end
  end
end
