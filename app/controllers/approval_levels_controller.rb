class ApprovalLevelsController < ApplicationController
  before_filter :find_approval_level, only: [:edit, :update, :destroy]
  
  autocomplete :employee, :name
  def index
    # @approval_levels = ApprovalLevel.select('approval_levels.*, features.name AS features_name, users.name AS approver_name').joins("INNER JOIN features ON (features_id=features.id) INNER JOIN users ON (users_id=user.id")
    @approval_levels = @current_company.approval_levels
  end

  # def new
  #   @user = User.new
  #   @features = Features.all.map{|feature| [feature.name, feature.id] }
  # end

  def edit
    if @approval_level.approval_level_approvers.count == 0
      @approval_level.approval_level_approvers.build
    end
  end

  def update
    @approval_level = ApprovalLevel.find_by_id(params[:id])
    @approval_level.update(approval_level_params)
    respond_to do |format|
      format.js
    end
  end

  def autocomplete_employee_name
    render json: Employee.where("name like '%#{params[:term]}%'").map { |employee| {label: employee.name.to_s, value: employee.id.to_i} }
  end

private

  

  def find_approval_level
    @approval_level = ApprovalLevel.find(params[:id])
  end

  def approval_level_params
    params.require(:approval_level).permit(approval_level_approvers_attributes: [:id, :employee_id, :_destroy] )
  end
end
