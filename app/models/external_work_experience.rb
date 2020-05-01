class ExternalWorkExperience < ActiveRecord::Base
	belongs_to :employee

def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "name_of_company", "job_desc", "position", "start", "end", "achievement"]
    where(:employee_id => params[:id]).each do |external_work_experience|
      csv << [external_work_experience.employee.name, external_work_experience.name_of_company, external_work_experience.job_desc, external_work_experience.position, external_work_experience.start, external_work_experience.end, external_work_experience.achievement ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      external_work_experience = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      external_work_experience.update(parameters.permit(:name_of_company, :job_desc, :position, :start, :end, :achievement, :employee_id))
      external_work_experience.save!
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