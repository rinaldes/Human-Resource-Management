class ExternalWorkExperiencesController < ApplicationController

	def index
		@external_work_experiences = ExternalWorkExperience.where(:employee_id => params[:id])
		respond_to do |format|
      format.html
      format.csv { send_data @external_work_experiences.to_csv(params) }
      #format.template { send_data @education_details.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import
  
  ExternalWorkExperience.import(params[:file])
  redirect_to employee_histories_path(:id => params[:id]), notice: "Imported success."
	
	end

	def new

		@external_work_experience = ExternalWorkExperience.new
		@position = ['Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  	respond_to do |format|
	    	format.js
		end
	end

		def create
		change_date_format(params)
		@external_work_experience = ExternalWorkExperience.new(external_work_experience_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:external_work_experience].present?
      if params[:external_work_experience][:start].present?
        base_date = params[:external_work_experience][:start].split("/")
        params[:external_work_experience][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:external_work_experience][:end].present?
        base_date = params[:external_work_experience][:end].split("/")
        params[:external_work_experience][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			ExternalWorkExperience.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@external_work_experience = ExternalWorkExperience.find_by_id(params[:id])
		@position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_external_work_experience
		@external_work_experience = ExternalWorkExperience.find_by_id(params[:external_work_experience][:id])
		@external_work_experience.update(external_work_experience_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def external_work_experience_params
			params.require(:external_work_experience).permit(:name_of_company, :job_desc, :position, :start, :end, :achievement, :employee_id)
		end
end
