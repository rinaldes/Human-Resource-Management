class SalariesController < ApplicationController
	def index
		@employee = Employee.find_by_id(params[:id])
		@salaries = Salary.where(:employee_id => params[:id])
		respond_to do |format|
    	format.html
    	format.csv { send_data @salaries.to_csv }
    	format.xls
  	end
	end

	def new
		@salary = Salary.new
		@employee = Employee.find(params[:employee_id])
		@position = @employee.position
		@a = true
	    respond_to do |format|
	      format.js
	    end
	end

	def import
	  Salary.import(params[:file])
	  redirect_to salaries_path(:id => params[:id]), notice: "Salaries imported."
	end

	def create
		@salary = Salary.new(salary_params.merge(date_of_performance: change_date_format ))
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format
     if params[:salary].present?
       if params[:salary][:date_of_performance].present?
         base_date = params[:salary][:date_of_performance].split("/")
         params[:salary][:date_of_performance] = base_date[2] + "-" + base_date[0] + "-" + base_date[1]
       end
     end
   end

	def destroy
		params[:check].each do |delete|
			Salary.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end

	end

	def edit
		@salary = Salary.find_by_id(params[:id])
		@a = false
		respond_to do |format|
	      format.js
	    end
	end

	def update_salary
		@salary = Salary.find_by_id(params[:salary][:id])
		@salary.update(salary_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def salary_params
			params.require(:salary).permit(:reason_of_adjustment, :basic, :transport, :date_of_performance, :from, :to, :employee_id)
		end
end
