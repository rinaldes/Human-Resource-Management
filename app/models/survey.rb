class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :survey_pages
  has_many :survey_responses
  has_many :survey_questions

  validates :name, presence: true, uniqueness: true

  self.per_page = 5
  
  def self.set_per_page(number)
    self.per_page = number
  end

end
