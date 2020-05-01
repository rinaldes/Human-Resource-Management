class ViolationDetail < ActiveRecord::Base
	belongs_to :employee
	
	def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "violation_type", "violation_description", "start", "due_date", "punishment"]
    where(:employee_id => params[:id]).each do |violation_detail|
      csv << [violation_detail.employee.name, violation_detail.violation_type, violation_detail.violation_description, violation_detail.start, violation_detail.due_date, violation_detail.punishment]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      violation_detail = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      violation_detail.update(parameters.permit(:violation_type, :violation_description, :start, :due_date, :punishment, :employee_id))
      violation_detail.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    violation_detail = find_by_id(row["id"]) || new
    violation_detail.attributes = row.to_hash.slice(*accessible_attributes)
    violation_detail.save!
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