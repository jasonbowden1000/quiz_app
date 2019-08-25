class ChoiceValidator < ActiveModel::Validator
  def validate(record) 
    if record.question_type == Rails.configuration.x.question_type.MULTIPLE_CHOICE
      true_choices = record.choices.select(&:truth_value)

      if record.choices.size < 2
        record.errors[:base] << "Multiple choice questions should have at least two choices"
      else
        record.errors[:base] << "Multiple choice questions should only have one correct choice." if true_choices.size > 1 
        record.errors[:base] << "All Multiple choice options cannot be false" if true_choices.size < 1
      end
    elsif record.question_type == Rails.configuration.x.question_type.MULTIPLE_ANSWER
      record.errors[:base] << "Multiple answer questions must have at least two choices" if record.choices.size < 2
    elsif record.question_type == Rails.configuration.x.question_type.TRUE_FALSE
      record.errors[:base] << "True-False questions must have one and only one option" if record.choices.size != 1 
      Rails.logger.info "Validating true false question"
      Rails.logger.info record
      Rails.logger.info record.choices
      Rails.logger.info record.choices.first.truth_value
    end
  end
end