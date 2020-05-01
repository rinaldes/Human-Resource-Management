class Goal < ActiveRecord::Base
	def self.to_csv(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["Goal Name"]
		  all.each do |goal|
		    csv << [goal.goal]
	  	end
  	end
	end

	def self.to_csv2(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["Goal Name"]
		  all.each do |goal|		    
	  	end
  	end
	end
	
def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
      goal = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      goal.update(parameters.permit(:goal))
      goal.save!
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
