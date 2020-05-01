class Schedule < ActiveRecord::Base
	before_create :end_after_start
	validates :start_period, :end_period, :presence => true
	has_many :schedule_details
	belongs_to :shift
	belongs_to :employee
	accepts_nested_attributes_for :schedule_details, :reject_if => :all_blank, :allow_destroy => true

	def self.to_csv(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["shift", "start_period", "end_period", "employee"]
		  all.each do |schedule|
		    csv << [schedule.shift.name, schedule.start_period, schedule.end_period, schedule.employee.name]
	  	end
  	end
	end

	def self.to_csv2(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["shift", "start_period", "end_period", "employee"]
		  all.each do |schedule|
		 end
  	end
	end
	
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
	      schedule = find_by_id(row["id"]) || new
      	employee_id = Employee.find_by_name(row.to_hash['employee'])
      	shift_id = Shift.find_by_name(row.to_hash['shift'])
	      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee_id.id, shift_id: shift_id.id))
	      schedule.update(parameters.permit(:employee_id, :shift_id, :start_period, :end_period))
	      schedule.save!
		end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Csv.new(file.path, nil, :ignore)
	  when ".xls" then Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	def end_after_start
		if end_period < start_period
			errors.add(:end_period, "Must be after start Period")
		end
	end
end
