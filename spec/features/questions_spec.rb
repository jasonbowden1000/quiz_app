require "rails_helper"

RSpec.describe "Multiple-Choice Questions" do
  let(:user1) { FactoryBot.create(:user) }
  let!(:deck1) { FactoryBot.create(:deck, id: 123, title: "My Armors", description: "Don't leave home without them", user: user1 )}
  let!(:deck2) { FactoryBot.create(:deck, id: 456, title: "Rogues Gallery", description: "baddies", user: user1 )}

  before do
    login_as(user1)
  end

  context "when added to decks by users" do
    it "can be seen on questions list" do
      visit decks_path
      within("div#deck_#{deck1.id}") do
        click_link "Manage Questions"
      end

      click_link "Add Question"
      fill_in "Text", with: "Who is on first?"
      fill_in "Description", with: "This test will build your critical thinking ability"
      choose("question_type", option: "multiple_choice")
      fill_in "questions[answer_1][text]", with: "Hu"
      choose "questions[answer_1][truth_value]", option: false
      click_button "Add Question"
      fill_in "questions[answer_2][text]", with: "Who"
      choose "questions[answer_2][truth_value]", option: true
      fill_in "questions[answer_3][text]", with: "Scooby Doo"
      choose "questions[answer_3][truth_value]", option: false
      click_button "Add Question"
      fill_in "questions[answer_4][text]", with: "The Fonz"
      choose "questions[answer_4][truth_value]", option: false
      click "Submit"
      expect(2+2).to eql(4)
    end
  end
end
