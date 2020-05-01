class AddTypeToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules, :schedule_type, :string
  end
end
