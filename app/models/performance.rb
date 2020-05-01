class Performance < ActiveRecord::Base
	belongs_to :employee

def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << ["employee_name", "date_of_performance", "rating", "area_of_strength", "area_of_development", "rater", "position_rater"]
    all.each do |performance|
      csv << [performance.employee.name, performance.date_of_performance, performance.rating, performance.area_of_strength, performance.area_of_development, performance.rater, performance.position_rater]
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      performance = find_by_id(row["ID"]) || new
      employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash.merge(employee_id: employee.id))
      performance.update(parameters.permit(:date_of_performance, :rating, :area_of_strength, :area_of_development, :rater, :position_rater, :employee_id))
      performance.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    performance = find_by_id(row["id"]) || new
    performance.attributes = row.to_hash.slice(*accessible_attributes)
    performance.save!
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
