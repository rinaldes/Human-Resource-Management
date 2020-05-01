class PhotoActivity < ActiveRecord::Base
  has_many :photo_receivers
  has_many :photo, :through => :photo_receivers
  has_many :photos

  belongs_to :user

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name"]
      all.each do |photo_activity|
        csv << [photo_activity.name]
      end
    end
  end

  def self.to_csv2(options = {})
    CSV.generate(options) do |csv|
      csv << ["name"]
        all.each do |photo_activity|
      end
    end
  end
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      photo_activity = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      photo_activity.update(parameters.permit(:name))
      photo_activity.save!
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
