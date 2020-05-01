class SurveyQuestion < ActiveRecord::Base
	belongs_to :survey
  has_many :response_questions
	serialize :question_varians, Array
end
