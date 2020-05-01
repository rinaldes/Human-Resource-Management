class CertificationsController < ApplicationController

	def index
		@certifications = Certification.where(:employee_id => params[:id])
		#@fields = Certification.column_names
    #filename = 'List certifications on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        format.csv { send_data @certifications.to_csv(params) }
        #format.template { send_data @education_details.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import

  Certification.import(params[:file])
  redirect_to employee_histories_path(:id => params[:id]), notice: "Imported Success."
	end

	def new

		@certification = Certification.new
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		change_date_format(params)
		@certification = Certification.new(certification_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:certification].present?
      if params[:certification][:date_of_certification].present?
        base_date = params[:certification][:date_of_certification].split("/")
        params[:certification][:date_of_certification] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			Certification.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@certification = Certification.find_by_id(params[:id])
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_certification
		@certification = Certification.find_by_id(params[:certification][:id])
		@certification.update(certification_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def certification_params
			params.require(:certification).permit(:institution, :certification_number, :name_of_certification, :date_of_certification, :description, :attachment, :employee_id)
		end
end