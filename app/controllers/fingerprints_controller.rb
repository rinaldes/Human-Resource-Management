class FingerprintsController < ApplicationController
	before_action :set_fingerprint, only: [:show, :edit, :update, :destroy]
  	before_action :set_fingerprints

	def index
		@fields = Fingerprint.column_names
	    filename = 'List Users on ' + DateTime.now.strftime("%d %B %Y %T").to_s
	    # respond_to do |format|
	    #   format.html
	    #   format.js
	    #   format.csv { send_data @fingerprints.to_csv, filename: filename + '.csv'}
	    #   format.xls do
	    #     response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
	    #   end
	    # end
	end

	def new
		@fingerprint = Fingerprint.new
	end

	def edit

	end

	def update
		@fingerprint.update(fingerprint_params)
	end

	def create
		@fingerprint = Fingerprint.new(fingerprint_params)
	    respond_to do |format|
	        format.html { redirect_to fingerprints_path }
	        format.js { render :create }
	    end
	end

	def destroy
		@fingerprint.destroy
		redirect_to fingerprints_path
	end



	private
	    def set_fingerprint
	      @fingerprint = Fingerprint.find(params[:id])
	    end

	    def set_fingerprints
	      base_fingerprint = Fingerprint.all
	      @fingerprints_count = base_fingerprint.count
	      @fingerprints = base_fingerprint.paginate(:page => params[:page])
	    end

	    def fingerprint_params
	    	params.require(:fingerprint).permit(:name, :ip_address, :port)
	    end


end
