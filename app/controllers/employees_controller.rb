class EmployeesController < ApplicationController
  before_action :set_employee, except: [:index, :new, :create, :destroy, :family_details, :new_family_details, :employee_working_datas, :new_employee_working_datas, :absence,
    :search_absence, :account_setting, :change_setting]
  before_action :set_employee, only: [:edit, :update, :delete, :show]

  respond_to :html
  before_action :set_params, only: [:show]

  def index
    conditions_or = []
    ["nik", 'name'].each{|f|
      conditions_or << "#{f} LIKE '%#{params[:search][:search]}%'"
    } if params[:search].present?
    @employees = Employee.where(conditions_or.join(' OR ')).paginate(page: params[:page], per_page: 100)
    @employees_count = Employee.where(conditions_or.join(' OR ')).count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @employee = Employee.find (params[:id])
    # session[:hrm][:employee_id] = params[:id]
    render "form1"
  end

  def account_setting
    @email = current_user.employee.corporate_email
  end

  def change_setting
    @email = current_user.employee.corporate_email.update(corporate_email_params)
    redirect_to account_setting_employees_path
  end

  def new_personal_data
    @employee = Employee.find (params[:format])
    @personal_data = @employee.build_personal_data
    @employee.build_health
    @employee.build_affair
    @employee.build_emergency_kontak
    @employee.contacts_number
    @organizations = Organization.all.map{|x| [x.name, x.id]}
    @religion = ['Islam', 'Kristen', 'Katolik', 'Budha', 'Hindu', 'Konghucu']
    @status = ['Lajang', 'Duda', 'Janda', 'Menikah']
  end

  def absence
    @employee = Employee.find_by_id(params[:id])
    @absences = Absence.get_employee_absence(params)
    @time = Date.today
  end

  def search_absence
    @absences = Absence.get_employee_absence(params)
    respond_to do |format|
      format.js
    end
  end

  def create_personal_data

  end

  def new
    @employee =Employee.new
    @organizations = Organization.all.map{|x| [x.name, x.id]}
    @shifts = Shift.all.map{|x| [x.name, x.id]}
    @status = ['Lajang', 'Duda', 'Janda', 'Menikah']
  end

def create
    @employee = Employee.new(employee_params)
    if @employee.save
      create_blank_relation
      respond_to do |format|
        format.html { redirect_to employees_path }
        format.js { render :create }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :create }
      end
    end
    # respond_with(@role)
  end

  def family_details
    @families = Family.all
  end

  def new_family_details
    @family = Family.new
    @status = ['Ayah', 'Ibu', 'Kakak', 'Adik', 'Istri', 'Suami', 'Anak']
    respond_to do |format|
      format.js
    end
  end

  def create_family_details

  end


  def position_details
    @position_details = PositionDetail.all
  end

  def new_position_details
    @position_detail = PositionDetail.new
    @position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
    @organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
    respond_to do |format|
      format.js
    end
  end

  def create_position_details

  end

  #def employee_working_datas
   # @employee_working_datas = Employee_working_data.all
  #end

  #def new_empolyee_working_datas
   # @employee_working_data = Employee_working_data.new
    #@Position = ['', 'Direktur Utama', 'Direktur', 'General Manager', 'Manager', 'Staff']
     # @Organization = ['', 'Solusindo IT', 'WGS', 'Pertamina', 'AHM', 'BI', 'etc']
    #respond_to do |format|
     # format.js
    #end
  #end

  #def create_employee_working_datas

  #end


  def edit
    @employee = Employee.find(params[:id])
    @organizations = Organization.all.map{|x| [x.name, x.id]}
    @religion = ['Islam', 'Kristen', 'Katolik', 'Budha', 'Hindu', 'Konghucu']
    @status = ['Lajang', 'Duda', 'Janda', 'Menikah']
  end

  def update
    # debugger
    @employee.update(employee_params)
    redirect_to employees_path
  end

  def update_approval
    # debugger
    @employee = Employee.find_by_id(params[:id])
  if params[:employee][:flag_employee] == "Approved"
    @employee.update(:flag_employee => true)
  else
    @employee.update(:flag_employee => false)
  end
    redirect_to approval_employees_path
  end
  


  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path, :notige => "Your Role has been deleted"
  end

 private
    def employee
        @flag = current_user.flag_employee
        if params[:flag].present?
          @flag.update(params[:flag] => false)
        end
        if @flag.present?
          if @flag.employee
            redirect_to action: 'employee'
          else
            current_user.update(:flag_employee => false)
            redirect_to action: 'index'
          end
        end
    end    

    def set_employee     
      @employee = Employee.find(params[:id])
    end

    def set_employees
      base_employee = Employee.all
      @employees_count = base_employee.count
      @employees = base_employee.paginate(:page => params[:page])
    end

    def employee_params
      params.require(:employee).permit(:company_id, :flag_employee, :nik, :name, :status, :duedate, :organization_id, :position, :shift, :first_name, :image, :last_name, :gender, :place, :birth, :age, :religion, :nationality, :email, corporate_email_attributes: [:email, :password, :_destroy], health_attributes: [:color_blind, :blood_type, :height, :weight, :history, :health_benefit, :_destroy], affair_attributes: [:nik, :start_work, :tax_status, :no_npwp, :no_id, :organization_id, :position_id, :_destroy], contact_attributes: [:home, :phone, :office, :emergency_name, :emergency_number, :emergency_relation, :_destroy], address_informations_attributes: [:id, :provinsi_id, :city_id, :kecematan_id, :rt, :rw, :kode_pos, :street, :_destroy])
    end

    # def health_params
    #   params.require(:health).permit(:color_blind, :blood_type, :height, :weight, :history, :health_benefit)
    # end

    # def affair_params
    #   params.require(:affair).permit(:nik, :start_work, :tax_status, :no_npwp, :no_id, :organization_id, :position_id)
    # end

    # def emergency_kontak
    #   params.require(:emergency_kontak).permit(:name, :phone_number, :relationship)
    # end

    # def contacts_number
    #   params.require(:contacts_number).permit(:home, :handphone, :office)
    # end

    def set_params
      # session[:hrm] = {} if session[:hrm].blank?
      params[:employee_id] = params[:id]
    end

    def create_blank_relation
      @employee.build_health.save
      @employee.build_affair.save
      @employee.build_contact.save
      # @employee.build_contacts_number.save
    end

    def corporate_email_params
      params.require(:corporate_email).permit(:email, :password, :password_confirmation)
    end
end
