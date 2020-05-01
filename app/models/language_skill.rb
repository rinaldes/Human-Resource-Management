class LanguageSkill < ActiveRecord::Base
	belongs_to :employee

	def self.to_csv(params, options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "language", "reading", "writing", "speaking" ]
    where(:employee_id => params[:id]).each do |language_skill|
      csv << [language_skill.employee.name, language_skill.language, language_skill.reading, language_skill.writing, language_skill.speaking ]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      language_skill = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      language_skill.update(parameters.permit(:language, :reading, :writing, :speaking, :employee_id))
      language_skill.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    language_skill = find_by_id(row["id"]) || new
    language_skill.attributes = row.to_hash.slice(*accessible_attributes)
    language_skill.save!
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