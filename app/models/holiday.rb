class Holiday < ActiveRecord::Base
  belongs_to :holiday_type
  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << ["name", "start", "end", "annual_leave", "mandays"]
    all.each do |holiday|
      csv << [holiday.name, holiday.start, holiday.end, holiday.annual_leave, holiday.mandays]
    end
  end
end

def self.to_csv2(options = {})
  CSV.generate(options) do |csv|
    csv << ["name", "start", "end", "annual_leave"]
    all.each do |holiday|
    end
  end
end

def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      holiday = find_by_id(row["start"]) || new
      #employee = Employee.find_by_name(row.to_hash['employee_name'])
      #raise row.to_hash.inspect
      parameters = ActionController::Parameters.new(row.to_hash)
      holiday.update(parameters.permit(:name, :start, :end, :annual_leave, :mandays))
      holiday.save!
    end
  end
=begin
def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    holiday = find_by_id(row["id"]) || new
    holiday.attributes = row.to_hash.slice(*accessible_attributes)
    holiday.save!
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
