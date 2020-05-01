class LeaveRequestsController < ApplicationController
  #before_action :set_leave_requests, only: [:index]
  #before_action :set_leave_request, only: [:show, :edit, :destroy, :update]

  def index
    @leave_time = AttendanceSetting.last.leave_reset
    @annual_leave = Holiday.where(:annual_leave => "TRUE").count
    @leave_left = (@leave_time - @annual_leave).to_i
    @leave_requests = LeaveRequest.all
    @leave_request = LeaveRequest.new
    @employee = Employee.find_by_user_id(current_user.id)
    # @approval_setting = ApprovalLevelApprover.find_by_employee_id(@employee.id)
    @approval_setting = @current_company.approval_levels.where(:feature_name => 'Leave Request').first.approval_level_approvers.find_by_employee_id(@employee)
     respond_to do |format|
      format.html
      if(params[:param] == "param")
        format.csv { send_data @leave_requests.to_csv2 }
      else
        format.csv { send_data @leave_requests.to_csv }
      end
      format.xls
    end  	
  end

  def new
  	@leave_request = LeaveRequest.new
    respond_to do |format|
      format.js
    end
  end

  def import
  LeaveRequest.import(params[:file])
  redirect_to leave_requests_path(:id => params[:id])
  end

  def create 
    @leave_request = LeaveRequest.new(leave_request_params.merge(start_date: change_date_format, :end_date => change_date_format2, status: "Pending"))
    respond_to do |format|
        format.js
    end
  end

  def change_date_format
    if params[:leave_request].present?
      if params[:leave_request][:start_date].present?
        base_date = params[:leave_request][:start_date].split("/")
        params[:leave_request][:start_date] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

    def change_date_format2
    if params[:leave_request].present?
      if params[:leave_request][:end_date].present?
        base_date = params[:leave_request][:end_date].split("/")
        params[:leave_request][:end_date] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

  def edit
    @leave_request = LeaveRequest.find_by_id(params[:id])
    respond_to do |format|
      format.js
      end
  end

  def update
    @leave_request = LeaveRequest.find_by_id(params[:leave_request][:id])
    @leave_request.update_attributes(leave_request_params)
    respond_to do |format|
        format.js
      end
  end

  def destroy   
    params[:check].each do |delete|
      LeaveRequest.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end
    end
  private
	  def set_leave_requests
	      base_leave_request = LeaveRequest.all
	      @leave_requests_count = base_leave_request.count
	      @leave_requests = base_leave_request.paginate(:page => params[:page])
	  end

    def leave_request_params
      params.require(:leave_request).permit(:name, :start_date, :end_date, :reason, :description, :status)
    end

    def set_leave_request
      @leave_request = LeaveRequest.find(params[:id])
    end
end
