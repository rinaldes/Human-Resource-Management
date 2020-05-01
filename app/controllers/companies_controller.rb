class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :set_companies

  def index
    @fields = Company.column_names
    filename = 'List Users on ' + DateTime.now.strftime("%d %B %Y %T").to_s
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @fingerprints.to_csv, filename: filename + '.csv'}
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
      end
    end
  end

  def new
    @company = Company.new
    @company.users.build
    @provinces = Province.all.map{|x| [x.name, x.id]}
  end

  def create
    @company = Company.new(company_params.merge(created_by: @current_user.id, joined_at: Time.now, code: Time.now.to_i))
    @provinces = Province.all.map{|x| [x.name, x.id]}
    @city = City.where(:province_id => params[:company][:province_id]).map{|x| [x.name, x.id]}
    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_path }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @company = Company.find_by_id(params[:id])
    @provinces = Province.all.map{|x| [x.name, x.id]}
    @cities = City.where(province_id: @company.province_id).map{|city|[city.name, city.id]}
  end

  def update
    @company = Company.find_by_id(params[:id])
    respond_to do |format|
      if @company.update_attributes(company_params)
        format.html { redirect_to companies_path }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        @provinces = Province.all.map{|x| [x.name, x.id]}
        @cities = City.where(province_id: @company.province_id).map{|city|[city.name, city.id]}
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def get_city
    @cities = City.where(:province_id => params[:prov_id]).map{|x| [x.name, x.id]}
    respond_to do |format|
      format.js
    end
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def set_companies
      base_company = Company.all
      @companies_count = base_company.count
      @companies = base_company.paginate(:page => params[:page])
    end

    def company_params
      params.require(:company).permit(
        :name, :phone, :address, :province_id, :city_id, :owner_name, :com_email, :com_logo, :joined_at, :postal_code, users_attributes: [:username, :password, :email]
      )
    end
end
