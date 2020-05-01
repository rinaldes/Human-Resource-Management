class OvertimeRequestsController < ApplicationController
  def index
  	@overtime_requests = OvertimeRequest.all
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @overtime_requests.to_csv2 }
      else
        format.csv { send_data @overtime_requests.to_csv }
      end
    end
  end

  def new
  	@overtime_request = OvertimeRequest.new
    respond_to do |format|
      format.js
    end
  end

  def import
    OvertimeRequest.import(params[:file])
    redirect_to overtime_requests_path, notice: "Overtime Requests imported."
  end

  def create
    @overtime_request = OvertimeRequest.new(overtime_request_params.merge(name: params[:overtime_request][:name]))
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      OvertimeRequest.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end

  end

  def edit
    @overtime_request = OvertimeRequest.find_by_id(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update
    @overtime_request = OvertimeRequest.find_by_id(params[:overtime_request][:id])
    @overtime_request.update_attributes(overtime_request_params)
    respond_to do |format|
        format.js
      end   
  end

  def change_date_format
     if params[:overtime_request].present?
       if params[:overtime_request][:date].present?
         base_date = params[:overtime_request][:date].split("/")
         params[:overtime_request][:date] = base_date[2] + "-" + base_date[0] + "-" + base_date[1]
       end
     end
   end

  def show
  end

  private
	  def set_overtime_requests
	      base_overtime_request = OvertimeRequest.all
	      @overtime_requests_count = base_overtime_request.count
	      @overtime_requests = base_overtime_request.paginate(:page => params[:page])
	  end

    def overtime_request_params
      params.require(:overtime_request).permit(:name, :date, :start_time, :end_time, :reason, :status)
    end

    def set_overtime_request
      @overtime_request = OvertimeRequest.find(params[:id])
    end
end
