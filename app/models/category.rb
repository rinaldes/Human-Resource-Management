class Category < ActiveRecord::Base
  has_many :knowledge, :through => :knowledge_receivers
  has_many :knowledge_receivers

  belongs_to :user, foreign_key: 'created_by'

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name"]
      all.each do |category|
        csv << [category.name]
      end
    end
  end

  def self.to_csv2(options = {})
    CSV.generate(options) do |csv|
      csv << ["name"]
      all.each do |category|
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      category = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      category.update(parameters.permit(:name))
      category.save!
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
