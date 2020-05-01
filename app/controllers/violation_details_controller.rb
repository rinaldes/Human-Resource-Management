class ViolationDetailsController < ApplicationController

	def index
		@violation_details = ViolationDetail.where(:employee_id => params[:id])
		#@fields = PositionDetail.column_names
    #filename = 'List position details on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
				format.csv { send_data @violation_details.to_csv(params) }
        #format.template { send_data @performances.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import
	  ViolationDetail.import(params[:file])
	   redirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
	end

	def new
		@violation_detail = ViolationDetail.new
	  respond_to do |format|
	   	format.js
		end
	end

	def create
		change_date_format(params)
		@violation_detail = ViolationDetail.new(violation_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:violation_detail].present?
      if params[:violation_detail][:start].present?
        base_date = params[:violation_detail][:start].split("/")
        params[:violation_detail][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:violation_detail][:due_date].present?
        base_date = params[:violation_detail][:due_date].split("/")
        params[:violation_detail][:due_date] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			ViolationDetail.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@violation_detail = ViolationDetail.find_by_id(params[:id])
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_violation_detail
		@violation_detail = ViolationDetail.find_by_id(params[:violation_detail][:id])
		@violation_detail.update(violation_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def violation_detail_params
			params.require(:violation_detail).permit(:violation_type, :violation_description, :start, :due_date, :punishment, :employee_id)
		end
end