class PositionDetail < ActiveRecord::Base
	 belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "start", "end", "position", "organization", "reason_for_change"]
    where(:employee_id => params[:id]).each do |position_detail|
      csv << [position_detail.employee.name, position_detail.start, position_detail.end, position_detail.position, position_detail.organization, position_detail.reason_for_change]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      position_detail = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      position_detail.update(parameters.permit(:start, :end, :position, :organization, :reason_for_change, :employee_id))
      position_detail.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    position_detail = find_by_id(row["id"]) || new
    position_detail.attributes = row.to_hash.slice(*accessible_attributes)
    position_detail.save!
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
