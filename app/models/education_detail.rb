class EducationDetail < ActiveRecord::Base
	belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "grade", "institution", "start", "end", "major", "final_score"]
    where(:employee_id => params[:id]).each do |education_detail|
      csv << [education_detail.employee.name, education_detail.grade, education_detail.institution, education_detail.start, education_detail.end, education_detail.major, education_detail.final_score ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      education_detail = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      education_detail.update(parameters.permit(:grade, :institution, :start, :end, :major, :final_score, :employee_id))
      education_detail.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    education_detail = find_by_id(row["id"]) || new
    education_detail.attributes = row.to_hash.slice(*accessible_attributes)
    education_detail.save!
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