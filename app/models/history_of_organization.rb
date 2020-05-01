class HistoryOfOrganization < ActiveRecord::Base

	belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "name", "phone_number", "position", "statue", "start", "end" ]
    where(:employee_id => params[:id]).each do |history_of_organization|
      csv << [history_of_organization.employee.name, history_of_organization.name, history_of_organization.phone_number, history_of_organization.position, history_of_organization.statue, history_of_organization.start, history_of_organization.end ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      history_of_organization = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      history_of_organization.update(parameters.permit(:name, :phone_number, :position, :statue, :start, :end, :employee_id))
      history_of_organization.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    contract = find_by_id(row["id"]) || new
    contract.attributes = row.to_hash.slice(*accessible_attributes)
    contract.save!
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
