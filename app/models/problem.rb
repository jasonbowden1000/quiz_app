class Problem < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
end