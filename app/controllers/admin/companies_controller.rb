class Admin::CompaniesController < ApplicationController
  layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!
  before_filter :admin_authentication
  before_filter :set_provinces
  before_filter :change_date_format, only: [:create, :update]
  before_action :set_company, only: [:show, :edit, :update, :destroy, :resend]

  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @companies = Company.paginate(:page => params[:page])
  end

  # GET /admin/companies/1
  # GET /admin/companies/1.json
  def show
  end

  # GET /admin/companies/new
  def new
    @company = Company.new
    @company.users.build
  end

  # GET /admin/companies/1/edit
  def edit
  end

  # POST /admin/companies
  # POST /admin/companies.json
  def create
    @company = Company.new(company_params)
    @company.users.build unless params[:company][:users_attributes]["0"][:username].present?

    respond_to do |format|
      if @company.save
        generate_code(@company)
        AdminMailer.registration_confirmation(@company).deliver
        # format.html { redirect_to admin_company_path(@company), notice: 'Company was successfully created.' }
        format.html { redirect_to admin_company_path(@company), notice: 'Please confirm your email address to continue.' }
        format.json { render :show, status: :created, location: @company }
      else
        revert_date_format
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/companies/1
  # PATCH/PUT /admin/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        generate_code(@company)
        format.html { redirect_to admin_company_path(@company), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        revert_date_format
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/companies/1
  # DELETE /admin/companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_city
    @cities = City.where(:province_id => params[:prov_id]).map{|x| [x.name, x.id]}
    respond_to do |format|
      format.js
    end
  end

  def search
    params_name = params[:q].present? ? params[:q].upcase.gsub("'", "\\\'").gsub("\"", "\\\"") : ""

    where_clauses = []
    where_clauses << "UPPER(com_email) LIKE '%#{params_name}%' OR UPPER(name) LIKE '%#{params_name}%' OR UPPER(owner_name) LIKE '%#{params_name}%'" if params_name.present?

    Company.set_per_page(params[:per_page]) if params[:per_page].present?

    @companies = Company.where(where_clauses.join(" AND ")).paginate(:page => params[:page])

    render :index
  end

  def resend
    if @company
      if @company.email_confirmed
        message = 'Company already confirmed.'
      else
        AdminMailer.registration_confirmation(@company).deliver
        message = 'Confirmation email has been sent to Company.'
      end
    else
      message = 'Couldn\'t find company.'
    end
    redirect_to admin_companies_url, notice: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :phone, :address, :province_id, :city_id, :com_logo, :owner_name, :com_email, :postal_code, :code, :joined_at, :is_active, users_attributes: [:username, :password, :password_confirmation, :email])
    end

    def set_provinces
      @provinces = Province.all.map{|x| [x.name, x.id]}
    end

    def change_date_format
      if params[:company].present?
        if params[:company][:joined_at].present?
          base_date = params[:company][:joined_at].split("/")
          params[:company][:joined_at] = "#{base_date[2]}-#{base_date[1]}-#{base_date[0]}"
        end
      end
    end

    def revert_date_format
      if params[:company].present?
        if params[:company][:joined_at].present?
          base_date = params[:company][:joined_at].split("/")
          params[:company][:joined_at] = base_date[1] + "/" + base_date[2] + "/" + base_date[0]
        end
      end
    end

    def generate_code(company)
      company_code = company.joined_at.strftime("%Y/%m/%d").to_s.split("/").join("").to_s + company.id.to_s
      company.update_attribute(:code, company_code.to_i)
    end
end
