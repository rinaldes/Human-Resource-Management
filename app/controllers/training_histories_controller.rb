class TrainingHistoriesController < ApplicationController
	
	def index
		@training_histories = TrainingHistory.where(:employee_id => params[:id])
		#fields = TrainingHistory.column_names
    #filename = 'List training histories on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        #format.js
				format.csv { send_data @training_histories.to_csv(params) }
        format.xls do
          #response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
        end
      end
	end

	def import
	  TrainingHistory.import(params[:file])
	  redirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
	end

	def new

		@training_history = TrainingHistory.new
		@sponsor = ['', '', '', '', '']
	  @result = ['', '', '', '', '', '']
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		change_date_format(params)
		@training_history = TrainingHistory.new(training_history_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:training_history].present?
      if params[:training_history][:start].present?
        base_date = params[:training_history][:start].split("/")
        params[:training_history][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:training_history][:end].present?
        base_date = params[:training_history][:end].split("/")
        params[:training_history][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			TrainingHistory.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit

		@training_history = TrainingHistory.find_by_id(params[:id])
		@sponsor = ['', '', '', '', '']
	  @result = ['', '', '', '', '', '']
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_training_history
		@training_history = TrainingHistory.find_by_id(params[:training_history][:id])
		@training_history.update(training_history_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def training_history_params
			params.require(:training_history).permit(:training_type, :start, :end, :sponsor, :result, :employee_id)
		end
end
