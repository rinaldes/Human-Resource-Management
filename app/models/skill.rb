class Skill < ActiveRecord::Base
	belongs_to :employee

	def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "skill_type"]
    where(:employee_id => params[:id]).each do |skill|
      csv << [skill.employee.name, skill.skill_type ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      skill = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      skill.update(parameters.permit(:skill_type, :employee_id))
      skill.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    skill = find_by_id(row["id"]) || new
    skill.attributes = row.to_hash.slice(*accessible_attributes)
    skill.save!
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
