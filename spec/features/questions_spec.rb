require "rails_helper"

RSpec.describe "New Multiple-Choice Questions" do
  MULTIPLE_CHOICE = 0
  let(:user1) { FactoryBot.create(:user) }
  let!(:deck1) { FactoryBot.create(:deck, title: "My Armors", description: "Don't leave home without them", user: user1 )}

  def fill_in_answer(index:, text:, truth_value:)
    fill_in "question[answers_attributes][#{index}][text]", with: text
    choose "question[answers_attributes][#{index}][truth_value]", option: truth_value
  end

  def setup_question
    fill_in "Text", with: "Who is on first?"
    fill_in "Description", with: "This test will build your critical thinking ability"
    choose "question[question_type]", option: MULTIPLE_CHOICE
  end

  before do
    login_as(user1)
    visit decks_path
    within("div#deck_#{deck1.id}") do
      click_link "Manage Questions"
    end

    click_link "Add Question"
  end

  context "when successfully created" do
    it "can be seen on questions list", js: true do
      setup_question
      add_answer = find("a#add_answer")
      3.times { add_answer.click }
      fill_in_answer(index: 0, text: "Hu", truth_value: false)
      fill_in_answer(index: 1, text: "Who", truth_value: true)
      fill_in_answer(index: 2, text: "Scooby Doo", truth_value: false)
      fill_in_answer(index: 3, text: "The Fonz", truth_value: false)

      click_button "Create Question"

      expect(page).to have_content "Question was successfully created."
    end
  end

  context "submitted with missing question text fields" do
    it "should display an error message", js: true do
      add_answer = find("a#add_answer")
      add_answer.click
      fill_in_answer(index: 0, text: "Hu", truth_value: false)
      fill_in_answer(index: 0, text: "Hu", truth_value: false)
      choose "question[answers_attributes][1][truth_value]", option: true
      click_button "Create Question"

      expect(page).to have_content "Text can't be blank" 
      # expect(page).to have_content "Answers cannot be blank"
    end

    it "should persist submitted data in dynamically generated fields", js: true do
      add_answer = find("a#add_answer")
      3.times { add_answer.click }
      fill_in_answer(index: 0, text: "Hu", truth_value: true)
      fill_in_answer(index: 1, text: "Who", truth_value: true)
      fill_in_answer(index: 2, text: "Scooby Doo", truth_value: false)
      fill_in_answer(index: 3, text: "The Fonz", truth_value: false)

      click_button "Create Question"

      expect(page.all(".answer").count).to eql(4)
      expect(page).to have_selector("input[value='The Fonz'")
      expect(find("#answer_true_1")).to be_checked
      expect(find("#answer_false_2")).to be_checked
    end
  end

  context "submitted with missing description fields" do
    it "should display an error message" do
      click_button "Create Question"
      expect(page).to have_content "Description can't be blank"
    end
  end

  # it "should ignore extra answers"

  context "submitted with more than one correct answer" do
    it "should display an error message", js: true do
      setup_question
      add_answer = find("a#add_answer")
      add_answer.click
      fill_in_answer(index: 0, text: "Hu", truth_value: true)
      fill_in_answer(index: 1, text: "Who", truth_value: true)

      click_button "Create Question"

      expect(page).to have_content "Multiple choice questions should only have one correct answer"
    end
  end

  context "with fewer than two submitted answers" do
    it "should display an error message", js: true do
      setup_question
      fill_in_answer(index: 0, text: "Hu", truth_value: true)

      click_button "Create Question"

      expect(page).to have_content "Multiple choice questions should have at least two choices"
    end
  end

  context "with all false answer submissions" do
    it "should display an error message", js: true do
      add_answer = find("a#add_answer")
      2.times { add_answer.click }
      fill_in_answer(index: 0, text: "Hu", truth_value: false)
      fill_in_answer(index: 1, text: "Who", truth_value: false)
      fill_in_answer(index: 2, text: "Scooby Doo", truth_value: false)

      click_button "Create Question"

      expect(page).to have_content "All Multiple choice options cannot be false"
    end
  end

  # it "should display an error message when written text is not alphanumeric"
end
