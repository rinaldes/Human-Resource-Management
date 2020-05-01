class ApprovalEmployeesController < ApplicationController
  def index
    @company = current_user.company
    conditions_or = []
    ["trim(to_char(nik, '99D'))", "name"].each{|f|
      conditions_or << "LOWER(#{f}) LIKE LOWER('%#{params[:search][:search]}%')"
    } if params[:search].present?
    @employees = @company.employees.where(conditions_or.join(' OR ')).paginate(page: params[:page], per_page: 100)
    @employees_count = @company.employees.where(conditions_or.join(' OR ')).count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @approval_employee = Employee.find(params[:id])
  end

  def update
    @approval_employee = Employee.find_by_id(params[:id])
  if params[:flag_employee] == "approved"
    @approval_employee.update_attributes(:flag_employee => true)
  else
    @approval_employee.update_attributes(:flag_employee => false)
  end
    redirect_to approval_employees_path
  end

   private
    def leave_employee_params
      params.require(:employee).permit(:flag_employee)
    end
end
