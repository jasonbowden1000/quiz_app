class AnswerValidator < ActiveModel::Validator
  MULTIPLE_CHOICE = 0

  def validate(record) 
    if record.question_type == MULTIPLE_CHOICE
      true_answers = record.answers.select { |answer| answer.truth_value == true }

      if record.answers.size < 2
        record.errors[:base] << "Multiple choice questions should have at least two choices"
      else
        if true_answers.size > 1
          record.errors[:base] << "Multiple choice questions should only have one correct answer." 
        elsif true_answers.size < 1
          record.errors[:base] << "All Multiple choice options cannot be false"
        end
      end
    end
  end
end