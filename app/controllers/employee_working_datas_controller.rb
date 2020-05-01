class EmployeeWorkingDatasController < ApplicationController
	
	def index
		@employee_working_datas = EmployeeWorkingData.all
		@position_details = PositionDetail.where(:employee_id => params[:id])
		@employee = Employee.find_by_id(params[:id])
		@contracts = Contract.where(:employee_id => params[:id])
		@training_histories = TrainingHistory.where(:employee_id => params[:id])
		@language_skills = LanguageSkill.where(:employee_id => params[:id])
		@skills = Skill.where(:employee_id => params[:id])
		@violation_details = ViolationDetail.where(:employee_id => params[:id])
	end

	#def import
	 # EmployeeWorkingData.import(params[:file])
	  #redirect_to employee_working_datas_path(:id => params[:id]), notice: "imported succses."
		#end

	def new
		@employee_working_data = EmployeeWorkingData.new
		@Position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @Organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		@employee_working_data = EmployeeWorkingData.new(employee_working_data_params)
		respond_to do |format|
	 		format.js
		end
	end

	def destroy
		params[:check].each do |delete|
			EmployeeWorkingData.find_by_id(delete).destroy
		end
		respond_to do |format|
	  	format.js
	  end
	end

	def edit
		@employee_working_data = EmployeeWorkingData.find_by_id(params[:id])
		@Position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @Organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
		respond_to do |format|
	  	format.js
		end
	end

	def update_employee_working_data
		@employee_working_data = EmployeeWorkingData.find_by_id(params[:employee_working_data][:id])
		@employee_working_data.update(employee_working_data_params)
		respond_to do |format|
		  format.js
		end
	end

	private
		def employee_working_data_params
			params.require(:employee_working_data).permit(:position_details_attributes [:start, :end, :position, :organization, :reason_for_change, :employee_id ], :contracts_attributes [:contract_type, :start, :end, :attachment, :employee_id ], :training_histories_attributes [:training_type, :start, :end, :sponsor, :result, :employee_id], :language_skills_attributes[:language, :reading, :writing, :speaking, :employee_id ], :skills_attributes [:skill_type, :employee_id ], :violation_details_attributes, [:violation_type, :violation_description, :start, :due_date, :punishment ])
	end
end
