class Certification < ActiveRecord::Base


	belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "institution", "certification_number", "name_of_certification", "date_of_certification", "description", "attachment" ]
    where(:employee_id => params[:id]).each do |certification|
      csv << [certification.employee.name, certification.institution, certification.certification_number, certification.name_of_certification, certification.date_of_certification, certification.description, certification.attachment ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      certification = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      certification.update(parameters.permit(:institution, :certification_number, :name_of_certification, :date_of_certification, :description, :attachment, :employee_id))
      certification.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    certification = find_by_id(row["id"]) || new
    certification.attributes = row.to_hash.slice(*accessible_attributes)
    certification.save!
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