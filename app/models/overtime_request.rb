class OvertimeRequest < ActiveRecord::Base
	def self.to_csv(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["name", "date", "start_time", "end_time", "reason", "status"]
		  all.each do |overtime_request|
		    csv << [overtime_request.name, overtime_request.date, overtime_request.start_time.strftime("%H:%M"), overtime_request.end_time.strftime("%H:%M"), overtime_request.reason, overtime_request.status]
	  	end
  	end
	end

	def self.to_csv2(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["name", "date", "start_time", "end_time", "reason"]
		  all.each do |overtime_request|
		    #csv << [overtime_request.name, overtime_request.date, overtime_request.start_time.strftime("%H:%M"), overtime_request.end_time.strftime("%H:%M"), overtime_request.reason, overtime_request.status]
	  	end
  	end
	end
	
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
	      overtime_request = find_by_id(row["id"]) || new
	      parameters = ActionController::Parameters.new(row.to_hash)
	      overtime_request.update(parameters.permit(:name, :date, :start_time, :end_time, :reason))
	      overtime_request.save!
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
end
