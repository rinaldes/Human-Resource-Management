class AssetAssignmentsController < ApplicationController

  before_action :set_asset_assignments, only: [:index]
  before_action :set_asset_assignment, only: [:show, :edit, :destroy, :update]
  before_action :set_employee_id, only: [:create, :update]

  def index
  	
  end

  def new
  	@asset_assignment = AssetAssignment.new
  end

  def create
    @asset_assignment = AssetAssignment.new(asset_assignment_params)
    respond_to do |format|
      if @asset_assignment.save
        format.html { redirect_to(@asset_assignment, :notice => 'Asset Assignment was successfully created.') }
        format.xml  { render :xml => @asset_assignment, :status => :created, :location => @asset_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def return
    @detail = AssetAssignmentDetail.find_by_id(params[:return_id])
    @detail.update(:returned => true)
    respond_to do |format|
      format.js
    end
  end

  

  private
	  def set_asset_assignments
	      base_asset_assignment = AssetAssignment.all
	      @asset_assignments_count = base_asset_assignment.count
	      @asset_assignments = base_asset_assignment.paginate(:page => params[:page])
	  end

    def asset_assignment_params
      params.require(:asset_assignment).permit(:employee_id, asset_assignment_details_attributes: [:id, :asset_type, :name, :serial_number, :date, :_destroy])
    end

    def set_asset_assignment
      @asset_assignment = AssetAssignment.find(params[:id])
    end

    def set_employee_id
      params[:asset_assignment][:employee_id] = Employee.find_by_name(params[:asset_assignment][:employee_id]).id
    end

end
