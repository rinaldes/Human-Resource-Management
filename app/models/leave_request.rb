class LeaveRequest < ActiveRecord::Base
  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << ["name", "start_date", "end_date", "reason", "description", "status"]
    all.each do |leave_request|
      csv << [leave_request.name, leave_request.start_date, leave_request.end_date, leave_request.reason, leave_request.description, leave_request.status]
    end
  end
end

def self.to_csv2(options = {})
  CSV.generate(options) do |csv|
    csv << ["name", "start_date", "end_date", "reason", "description"]
    all.each do |leave_request|
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      leave_request = find_by_id(row["ID"]) || new
      #employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash)
      leave_request.update(parameters.permit(:name, :start_date, :end_date, :reason, :description, :status))
      leave_request.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    leave_request = find_by_id(row["id"]) || new
    leave_request.attributes = row.to_hash.slice(*accessible_attributes)
    leave_request.save!
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
