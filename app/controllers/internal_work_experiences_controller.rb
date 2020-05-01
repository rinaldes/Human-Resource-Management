class InternalWorkExperiencesController < ApplicationController

	def index
		@internal_work_experiences = InternalWorkExperience.where(:employee_id => params[:id])
		respond_to do |format|
      format.html
      format.csv { send_data @internal_work_experiences.to_csv(params) }
      #format.template { send_data @education_details.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import
  
  InternalWorkExperience.import(params[:file])
  redirect_to employee_histories_path(:id => params[:id]), notice: "Imported success."
	
	end

	def new

		@internal_work_experience = InternalWorkExperience.new
		@position = ['Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @organization = ['Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']

	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		change_date_format(params)
		@internal_work_experience = InternalWorkExperience.new(internal_work_experience_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:internal_work_experience].present?
      if params[:internal_work_experience][:start].present?
        base_date = params[:internal_work_experience][:start].split("/")
        params[:internal_work_experience][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:internal_work_experience][:end].present?
        base_date = params[:internal_work_experience][:end].split("/")
        params[:internal_work_experience][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			InternalWorkExperience.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@internal_work_experience = InternalWorkExperience.find_by_id(params[:id])
		@position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
		@organization = ['Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_internal_work_experience
		@internal_work_experience = InternalWorkExperience.find_by_id(params[:internal_work_experience][:id])
		@internal_work_experience.update(internal_work_experience_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def internal_work_experience_params
			params.require(:internal_work_experience).permit(:name_of_company, :job_desc, :position, :organization, :start, :end, :achievement, :employee_id)
		end
end