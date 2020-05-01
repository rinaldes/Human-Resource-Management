class GoalValue < ActiveRecord::Base

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Value Name"]
      all.each do |goal_value|
        csv << [goal_value.value]
      end
    end
  end

  def self.to_csv2(options = {})
    CSV.generate(options) do |csv|
      csv << ["Value Name"]
      all.each do |goal_value|        
      end
    end
  end
  
def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
      goal_value = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      goal_value.update(parameters.permit(:value))
      goal_value.save!
  end
end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
