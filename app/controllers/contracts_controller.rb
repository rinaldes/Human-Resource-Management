class ContractsController < ApplicationController
	
	 def index
	 	@contracts = Contract.where(:employee_id => params[:id])
	 		#@fields = Contract.column_names
    #filename = 'List position details on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        format.csv { send_data @contarcts.to_csv(params) }
        format.xls 
      end
	end

	def import
  	Contract.import(params[:file])
  	 redirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
	end

	def new
		@contract = Contract.new
	  	respond_to do |format|
	    	format.js
			end
	end

	def create
		change_date_format(params)
		@contract = Contract.new(contract_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:contract].present?
      if params[:contract][:start].present?
        base_date = params[:contract][:start].split("/")
        params[:contract][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:contract][:end].present?
        base_date = params[:contract][:end].split("/")
        params[:contract][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			Contract.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	  end
	end
def edit
		@contract = Contract.find_by_id(params[:id])
  	respond_to do |format|
    	format.js
		end
	end

	def update_contract
		@contract = Contract.find_by_id(params[:contract][:id])
		@contract.update(contract_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def contract_params
			params.require(:contract).permit(:contract_type, :start, :end, :attachment, :employee_id)
		end
end
