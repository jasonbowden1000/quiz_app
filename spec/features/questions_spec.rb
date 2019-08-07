require "rails_helper"

RSpec.describe "New Multiple-Choice Questions" do
  let(:user1) { FactoryBot.create(:user) }
  let!(:deck1) { FactoryBot.create(:deck, id: 123, title: "My Armors", description: "Don't leave home without them", user: user1 )}
  let!(:deck2) { FactoryBot.create(:deck, id: 456, title: "Rogues Gallery", description: "baddies", user: user1 )}

  before do
    login_as(user1)
    visit decks_path
    within("div#deck_#{deck1.id}") do
      click_link "Manage Questions"
    end

    click_link "Add Question"
  end

=begin
    it "can be seen on questions list"
      fill_in "Text", with: "Who is on first?"
      fill_in "Description", with: "This test will build your critical thinking ability"
      choose "question_type", option: "multiple_choice"
      fill_in "question[answer_1][text]", with: "Hu"
      choose "question[answer_1][truth_value]", option: false
      add_answer = find("a#add_answer")
      add_answer.click
      fill_in "question[answer_2][text]", with: "Who"
      choose "question[answer_2][truth_value]", option: true
      add_answer.click
      fill_in "question[answer_3][text]", with: "Scooby Doo"
      choose "question[answer_3][truth_value]", option: false
      add_answer.click
      fill_in "question[answer_4][text]", with: "The Fonz"
      choose "question[answer_4][truth_value]", option: false
      click_button "Create Question"

      expect(page).to have_content "Your Decks"
    end
=end

  context "submitted with missing text fields" do
    it "should display an error message" do
      click_button "Create Question"
      expect(page).to have_content "Text can't be blank" 
    end
  end

  context "submitted with missing description fields" do
    it "should display an error message" do
      click_button "Create Question"
      expect(page).to have_content "Description can't be blank"
    end
  end

  it "should ignore extra answers"

  context "submitted with more than one correct answer" do
    it "should display an error message", js: true do
      fill_in "Text", with: "Who is on first?"
      fill_in "Description", with: "This test will build your critical thinking ability"
      choose "question[question_type]", option: 0 

      fill_in "question[answers_attributes][0][text]", with: "Hu"
      choose "question[answers_attributes][0][truth_value]", option: true
      add_answer = find("a#add_answer")
      add_answer.click
      fill_in "question[answers_attributes][1][text]", with: "Who"
      choose "question[answers_attributes][1][truth_value]", option: true

      click_button "Create Question"
      expect(page).to have_content "Multiple choice questions should only have one correct answer"
    end
  end

  it "should display an error message when no correct answer is submitted"
  it "should display an error message when fewer than two answers are submitted"
  it "should display an error message when written text is not alphanumeric"
end
