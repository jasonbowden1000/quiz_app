require "rails_helper"

RSpec.describe "Attempts" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, user: user1) }

  describe "can be started by users" do
    it "by clicking the Take test button" do
      login_as(user1)
      visit quizzes_path
      within("div#quiz_#{quiz1.id}") do
        click_button "Take Quiz"
      end

      # expect page to hvae some stuff
    end
  end
end
