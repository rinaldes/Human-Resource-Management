class Employee < ActiveRecord::Base
	resourcify
	mount_uploader :image, ImageUploader
	belongs_to :company
	belongs_to :user
	has_many :appraisals
	belongs_to :user
	belongs_to :organization
	belongs_to :shift
	has_many :approval_level_approvers
	has_many :schedules
	has_many :salaries
	has_many :absences
	has_many :families
	has_many :performances
	has_many :employee_working_datas
	has_many :employee_histories
	has_many :position_details
	has_many :contracts
	has_many :training_histories
	has_many :language_skills
	has_many :skills
	has_one :corporate_email
	has_many :asset_assignments
	has_many :violation_details
	has_many :education_details
	has_many :external_work_experiences
	has_many :internal_work_experiences
	has_many :history_of_organizations
	has_many :certifications
	has_one :health, dependent: :destroy
  	accepts_nested_attributes_for :health, :reject_if => :all_blank, :allow_destroy => true
	has_one :affair, dependent: :destroy
  	accepts_nested_attributes_for :affair, :reject_if => :all_blank, :allow_destroy => true
	has_one :contact, dependent: :destroy
	accepts_nested_attributes_for :contact, :reject_if => :all_blank, :allow_destroy => true
	
	# has_one :emergency_kontak, dependent: :destroy
 #  	accepts_nested_attributes_for :emergency_kontak, :reject_if => :all_blank, :allow_destroy => true
	# has_one :contacts_number, dependent: :destroy
 #  	accepts_nested_attributes_for :contacts_number, :reject_if => :all_blank, :allow_destroy => true
	has_one :personal_data
	has_many :address_informations
	has_many :schedule_details
	accepts_nested_attributes_for :address_informations, :reject_if => :all_blank, :allow_destroy => true

	def full_name
		self.first_name + ' ' + self.last_name
	end

	def has_check_in
		if self.absences.count > 0
	    	return (self.absences.last.date.to_s == Time.now.strftime('%Y-%m-%d').to_s)
	    else
	    	return false
	    end
	end

	def not_check_out
		absence = self.absences.find_by_date(Time.now.strftime('%Y-%m-%d').to_s)
		if absence.present?
			return absence.check_out.present?
		else
			return false
		end
	end


end
