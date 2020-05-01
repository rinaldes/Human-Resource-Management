class EmployeeHistoriesController < ApplicationController
	
	def index
		@employee_histories = EmployeeHistory.all
		@education_details = EducationDetail.where(:employee_id => params[:id])
		@external_work_experiences = ExternalWorkExperience.where(:employee_id => params[:id])
		@internal_work_experiences = InternalWorkExperience.where(:employee_id => params[:id])
		@history_of_organizations = HistoryOfOrganization.where(:employee_id => params[:d])
		@certifications = Certification.where(:employee_id => params[:id])
		@employee = Employee.find_by_id(params[:id])
	end

 	def import
	  EmployeeHistory.import(params[:file])
	  redirect_to employee_histories_path(:id => params[:id]), notice: "imported succses."
		end

	def new
		@employee_history = EmployeeHistory.new
		@Position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @Organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		@employee_history = EmployeeHistory.new(employee_history_params)
		respond_to do |format|
	 		format.js
		end
	end

	def destroy
		params[:check].each do |delete|
			EmployeeHistory.find_by_id(delete).destroy
		end
		respond_to do |format|
	  	format.js
	  end
	end

	def edit
		@employee_history = EmployeeHistory.find_by_id(params[:id])
		@Position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @Organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
		respond_to do |format|
	  	format.js
		end
	end

	def update_employee_history
		@employee_history = EmployeeHistory.find_by_id(params[:employee_history][:id])
		@employee_history.update(employee_history_params)
		respond_to do |format|
		  format.js
		end
	end

	private
		def employee_history_params
			params.require(:employee_history).permit(:education_details_attributes [:grade, :institution, :start, :end, :major, :final_score, :employee_id ], :external_work_experiences_attributes [:name_of_company, :job_desc, :position, :start, :end, :achievement, :employee_id ], :internal_work_experiences_attributes [:name_of_company, :job_desc, :position, :organization, :start, :end, :achievement, :employee_id ], :history_of_organizations_attributes [:name, :phone_number, :position, :statue, :start, :end, :employee_id ], :certifications_attributes [:institution, :certification_number, :name_of_certification, :date_of_certification, :description , :attachment, :employee_id ])
	end
end
