class EmployeeResignsController < ApplicationController
	def index
		
	end

	def new
		@employee_resign = EmployeeResign.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@employee_resign = EmployeeResign.new(employee_resign_params)
		if @employee_resign.save
			@employee = Employee.find_by_id(params[:employee_resign][:employee_id])
			@user = User.find_by_id(@employee.user_id)
			@user.update(:status => "inactive")
		end
		respond_to do |format|
			format.js
		end
	end

	private
		def employee_resign_params
			params.require(:employee_resign).permit(:date_of_resign, :reason_of_resign, :employee_id)
		end
end