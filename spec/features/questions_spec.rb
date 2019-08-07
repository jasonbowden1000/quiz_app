require "rails_helper"

RSpec.describe "Multiple-Choice Questions" do
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

  context "when added to decks by users" do
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

    it "should check for a missing text field" do
      click_button "Create Question"
      expect(page).to have_content "Text can't be blank" 
    end

    it "should check for a missing description field" do
      click_button "Create Question"
      expect(page).to have_content "Description can't be blank"
    end

    it "should ignore extra answers"

    context "should display an error" do
      it "when more than one correct answer is given", js: true do
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

      it "when no correct answer is submitted"

      it "when fewer than two answers are submitted"

      it "when written text is not alpha numeric"
    end
  end
end
