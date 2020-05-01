class SchedulesController < ApplicationController
	before_action :get_employees
	autocomplete :employee, :name, :full => true

	def index
		@employee = Employee.all
		@schedules = Schedule.all
		@schedule_details = ScheduleDetail.all

		respond_to do |format|
			format.html
			format.xls
	    format.xls
	    if(params[:a] == "a")
	      format.csv { send_data @schedules.to_csv2 }
	    else
	      format.csv { send_data @schedules.to_csv }
	    end
	  end
	end

	def edit
    @employee = Employee.all
		@schedules = Schedule.find(params[:id])
		@details = ScheduleDetail.where(:schedule_id => params[:id])
 	 end

	def show
		@employee = Employee.all
		@schedules = Schedule.find(params[:id])
	end

	def update
		@schedule = Schedule.find_by_id(params[:id])
		@schedule.update(schedule_params)
		redirect_to schedules_path
	end

	def import
    Schedule.import(params[:file])
    redirect_to schedules_path, notice: "Schedules imported."
  end

	def new
		@schedule = Schedule.new
		@shifts = Shift.all.map{|x| [x.name, x.id]}
		@organizations = Organization.all.map{|x| [x.name, x.id]}
	end

	def destroy
    params[:check].each do |delete|
      Schedule.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
    end
  end

	def create
		employee = Employee.find_by_name(params[:schedule][:employee_id])
		@schedule = Schedule.new(schedule_params.merge(employee_id: employee.id))
		if @schedule.save
			#details = ActiveSupport::JSON.decode(params[:many_employee])
			#details.each do |detail|
			begin
				params[:schedule][:schedule_details_attributes].values.each do |item|
					employee2 = Employee.find_by_name(item[:employee_id])
					@schedule.schedule_details.build(:employee_id => employee2.id).save
				end
				respond_to do |format|
		      format.html { redirect_to schedules_path }
		      format.js { render :create }
		    end
		  rescue
		  	respond_to do |format|
		      format.html { redirect_to schedules_path }
		      format.js { render :create }
		    end
		  end
		else
			respond_to do |format|
	      format.html { redirect_to schedules_path }
	      format.js { render :create }
	    end
		end	
	end

	private
		def schedule_params
			params.require(:schedule).permit(:start_period, :end_period, :shift_id, :schedule_type, :organization_id, :employee_id, :company_id, schedule_details_attributes: [:id, :employee_id, :_destroy])
		end

	private
	  def get_employees
	    @employees = Employee.all.map { |e| [e.name, e.id] }
	  end

	
end
