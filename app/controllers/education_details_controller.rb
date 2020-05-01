class EducationDetailsController < ApplicationController

	def index
		
		@education_details = EducationDetail.where(:employee_id => params[:id])
		respond_to do |format|
    	format.html
    	format.csv { send_data @education_details.to_csv(params) }
    	format.xls
  	end
	end

	def import

  EducationDetail.import(params[:file])
  redirect_to employee_histories_path(:id => params[:id]), notice: "Imported Success."
	end

	def new

		@education_detail = EducationDetail.new
		@grade = ['SD', 'SMP', 'SMA', 'Sarjana', 'Magister', 'Doktor']
	  	respond_to do |format|
	    	format.js
		end
	end

		def create
		change_date_format(params)
		@education_detail = EducationDetail.new(education_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:education_detail].present?
      if params[:education_detail][:start].present?
        base_date = params[:education_detail][:start].split("/")
        params[:education_detail][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:education_detail][:end].present?
        base_date = params[:education_detail][:end].split("/")
        params[:education_detail][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			EducationDetail.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@education_detail = EducationDetail.find_by_id(params[:id])
	  @grade = ['SD', 'SMP', 'SMA', 'Sarjana', 'Magister', 'Doktor']	
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_education_detail
		@education_detail = EducationDetail.find_by_id(params[:education_detail][:id])
		@education_detail.update(education_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def education_detail_params
			params.require(:education_detail).permit(:grade, :institution, :start, :end, :major, :final_score, :employee_id)
		end
end