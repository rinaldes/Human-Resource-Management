class TrainingHistory < ActiveRecord::Base
	belongs_to :employee

	def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "training_type", "start", "end", "sponsor", "result" ]
    where(:employee_id => params[:id]).each do |training_history|
      csv << [training_history.employee.name, training_history.training_type, training_history.start, training_history.end, training_history.sponsor, training_history.result ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      training_history = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      training_history.update(parameters.permit(:training_type, :start, :end, :sponsor, :result, :employee_id))
      training_history.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    training_history = find_by_id(row["id"]) || new
    training_history.attributes = row.to_hash.slice(*accessible_attributes)
    training_history.save!
  end
end
=end
def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end