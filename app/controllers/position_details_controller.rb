class PositionDetailsController < ApplicationController

	def index
		@position_details = PositionDetail.where(:employee_id => params[:id])
		#@fields = PositionDetail.column_names
    #filename = 'List position details on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        format.csv { send_data @position_details.to_csv(params) }
        #format.template { send_data @performances.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	 def import
	  PositionDetail.import(params[:file])
	  redirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
	end


	def new

		@position_detail = PositionDetail.new
		@position = ['Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @organization = ['Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		change_date_format(params)
		@position_detail = PositionDetail.new(position_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:position_detail].present?
      if params[:position_detail][:start].present?
        base_date = params[:position_detail][:start].split("/")
        params[:position_detail][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:position_detail][:end].present?
        base_date = params[:position_detail][:end].split("/")
        params[:position_detail][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			PositionDetail.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@position_detail = PositionDetail.find_by_id(params[:id])
		@position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  @organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
  	respond_to do |format|
    	format.js
		end
	end

	def update_position_detail
		@position_detail = PositionDetail.find_by_id(params[:position_detail][:id])
		@position_detail.update(position_detail_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def position_detail_params
			params.require(:position_detail).permit(:start, :end, :position, :organization, :reason_for_change, :employee_id)
		end
end
