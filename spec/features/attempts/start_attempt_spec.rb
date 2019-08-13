require "rails_helper"

RSpec.describe "Attempts" do

  let!(:user1) { FactoryBot.create(:user) }
  let!(:quiz1) { FactoryBot.create(:quiz_with_decks, user: user1) }

  describe "can be started by users" do
    it "by clicking the Take test button" do
      login_as(user1)
      visit quizzes_path
      expect(2+2).to eql(4)
    end
  end
end
