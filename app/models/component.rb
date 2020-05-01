class Component < ActiveRecord::Base
	
	def self.to_csv(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["name", "indicator"]
		  all.each do |component|
		    csv << [component.name, component.indicator]
	  	end
  	end
	end

	def self.to_csv2(options = {})
	 	CSV.generate(options) do |csv|
		  csv << ["name", "indicator"]
		  all.each do |component|
		  end
  		end
	end
	
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
      component = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      component.update(parameters.permit(:name, :indicator))
      component.save!
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