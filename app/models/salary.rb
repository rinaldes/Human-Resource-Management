class Salary < ActiveRecord::Base
	belongs_to :employee

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
		    csv << ["employee_name", "reason_of_adjustment", "basic", "transport", "date_of_performance", "from", "to"]
		    all.each do |salary|
		      #csv << item.attributes.values_at(*column_names)
		      csv << [salary.employee.name, salary.reason_of_adjustment, salary.basic, salary.transport, salary.date_of_performance, salary.from, salary.to]
		    end
	  end
	end
	
def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
      salary = find_by_id(row["id"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #parameters = ActionController::Parameters.new(row.to_hash)
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      salary.update(parameters.permit(:employee_id, :reason_of_adjustment, :basic, :transport, :date_of_performance, :from, :to))
      
      salary.save!
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
