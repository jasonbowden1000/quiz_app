class ChoiceValidator < ActiveModel::Validator
  def validate(record) 
    if record.question_type == Rails.configuration.x.question_type.MULTIPLE_CHOICE
      true_choices = record.choices.select { |choice| choice.truth_value == true }

      if record.choices.size < 2
        record.errors[:base] << "Multiple choice questions should have at least two choices"
      else
        if true_choices.size > 1
          record.errors[:base] << "Multiple choice questions should only have one correct choice." 
        elsif true_choices.size < 1
          record.errors[:base] << "All Multiple choice options cannot be false"
        end
      end
    end
  end
end