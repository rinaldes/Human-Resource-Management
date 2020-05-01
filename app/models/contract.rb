class Contract < ActiveRecord::Base
	
	belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "contract_type", "start", "end", "attachment" ]
    where(:employee_id => params[:id]).each do |contract|
      csv << [contract.employee.name, contract.contract_type, contract.start, contract.end, contract.attachment ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      contract = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      contract.update(parameters.permit(:contract_type, :start, :end, :attachment, :employee_id))
      contract.save!
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