module ChoiceHelpers
  def fill_in_choice(index:, text:, truth_value:)
    fill_in "choice_text_#{index}", with: text
    choose "choice_#{truth_value}_#{index}", option: truth_value
  end
end

RSpec.configure { |config| config.include ChoiceHelpers }