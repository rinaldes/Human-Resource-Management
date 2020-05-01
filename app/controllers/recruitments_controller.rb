class RecruitmentsController < ApplicationController

  before_action :set_recruitments, only: [:index]
  before_action :set_recruitment, only: [:show, :edit, :destroy, :update]

  def index
  	@employee = Employee.find_by_user_id(current_user.id)
    # @approval_setting = ApprovalLevelApprover.find_by_employee_id(@employee.id)
    @approval_setting = @current_company.approval_levels.where(:feature_name => 'Recruitment').first.approval_level_approvers.find_by_employee_id(@employee) rescue []
  end

  def edit
    @recruitment = Recruitment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def detail
    @recruitment = Recruitment.find(params[:id])
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    @recruitment.update(recruitment_params)
    redirect_to recruitments_path
  end

  def new
  	@recruitment = Recruitment.new
    letters = (0..9).to_a
    @code = letters.sample(8).join
    @organizations = Organization.all.map{|x| [x.name, x.id]}
    @positions = Organization.all.map{|x| [x.name, x.id]}
  end

  def create 
    @recruitment = Recruitment.new(recruitment_params)
    respond_to do |format|
      if @recruitment.save
        format.html { redirect_to(@recruitment, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @recruitment, :status => :created, :location => @recruitment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recruitment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_employee
    @recruitment = Recruitment.find(params[:recruitment_id])
    @recruitment.update(:status => "Closed")
    letters = (0..9).to_a
    @nik = letters.sample(5).join
    company_id = current_user.company_id
    @name = params[:name].delete(' ')
    @user = User.new(:email => params[:email], :username => @name, :status => "active" , :password => "12345678" , :password_confirmation => "12345678" , :company_id => company_id)
    if @user.save 
      @employee = @user.build_employee(:nik => @nik, :name => params[:name], :organization_id => params[:organization], :position => params[:position] ,:company_id => company_id)
      if @employee.save
        @employee.build_health.save
        @employee.build_affair.save
        @employee.build_contact.save
      end
    end
  end

  def show
    @test_result = TestResult.where(:recruitment_id => params[:recruitment_id])
  end

  private
	  def set_recruitments
	      base_recruitment = Recruitment.all
	      @recruitments_count = base_recruitment.count
	      @recruitments = base_recruitment.paginate(:page => params[:page])
	  end

    def recruitment_params
      params.require(:recruitment).permit(:no_recruitment, :user_id, :company_id , :organization_id, :man_power, :due_date, :requester, :status, :note, recruitment_details_attributes: [:id, :_destroy, :gender, :first_age, :last_age, :experience, :fresh_graduate, :skill, :organization_id, :position_id], recruitment_skills_attributes: [:id, :_destroy, :name], test_results_attributes: [:id, :destroy, :applicant_name, :attachment, :position, :score, :status, :recruitment_id], interview_results_attributes: [:id, :destroy, :test_result_id, :interview_result, :status, :recruitment_id])
    end

    def set_recruitment
      @recruitment = Recruitment.find(params[:id])
    end

end
