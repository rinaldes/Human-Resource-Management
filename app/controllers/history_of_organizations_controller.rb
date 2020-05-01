class HistoryOfOrganizationsController < ApplicationController

	def index

		@history_of_organizations = HistoryOfOrganization.where(:employee_id => params[:id])
		#@fields = Certification.column_names
    #filename = 'List certifications on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        format.csv { send_data @history_of_organizations.to_csv(params) }
        #format.template { send_data @education_details.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import

  HistoryOfOrganization.import(params[:file])
  redirect_to employee_histories_path(:id => params[:id]), notice: "Imported Success."
	end

	def new

		@history_of_organization = HistoryOfOrganization.new
		@position = ['Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		change_date_format(params)
		@history_of_organization = HistoryOfOrganization.new(history_of_organization_params)
		respond_to do |format|
	      format.js
	    end
	end

	def change_date_format(params)
    if params[:history_of_organization].present?
      if params[:history_of_organization][:start].present?
        base_date = params[:history_of_organization][:start].split("/")
        params[:history_of_organization][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  		if params[:history_of_organization][:end].present?
        base_date = params[:history_of_organization][:end].split("/")
        params[:history_of_organization][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
  		end
  	end
  end

	def destroy
		params[:check].each do |delete|
			HistoryOfOrganization.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@history_of_organization = HistoryOfOrganization.find_by_id(params[:id])
		@position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_history_of_organization
		@history_of_organization = HistoryOfOrganization.find_by_id(params[:history_of_organization][:id])
		@history_of_organization.update(history_of_organization_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def history_of_organization_params
			params.require(:history_of_organization).permit(:name, :phone_number, :position, :statue, :start, :end, :employee_id)
		end
end