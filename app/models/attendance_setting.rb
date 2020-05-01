class AttendanceSetting < ActiveRecord::Base
	def leave_time_other=(value)
		if leave_time2 == 'every'
    	self.leave_time2 = value
    end 
  end

  def leave_time_other
    leave_time2
  end
end