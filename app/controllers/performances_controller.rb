class PerformancesController < ApplicationController
	# autocomplete :performance, :rater
  	# def autocomplete_rater
    # render json: Employee.where("name like '%#{params[:term]}%'").map { |employee| {value: employee.name.to_s, text: employee.name.to_s} }
  	#end
	def index
		@employee = Employee.find_by_id(params[:id])
		@performances = Performance.where(:employee_id => params[:id])
		  respond_to do |format|
        format.html
        format.csv { send_data @performances.to_csv }
        #format.template { send_data @performances.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

  def import
  Performance.import(params[:file])
  redirect_to performances_path(:id => params[:id]), notice: "Performances imported."
end

	def new
		@performance = Performance.new
	    respond_to do |format|
	      format.js
	    end
	end

	def create
		@performance = Performance.new(performance_params.merge(date_of_performance: change_date_format ))
		respond_to do |format|
	      format.js
	    end
	end

  def change_date_format
    if params[:performance].present?
      if params[:performance][:date_of_performance].present?
        base_date = params[:performance][:date_of_performance].split("/")
        params[:performance][:date_of_performance] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

    def destroy
		params[:check].each do |delete|
			Performance.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@performance = Performance.find_by_id(params[:id])
		respond_to do |format|
	      format.js
	    end
	end

	def update
		@performance = Performance.find_by_id(params[:performance][:id])
		@performance.update_attributes(performance_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def performance_params
			params.require(:performance).permit(:date_of_performance, :rating, :area_of_strength, :area_of_development, :rater, :position_rater, :employee_id)
		end
end
