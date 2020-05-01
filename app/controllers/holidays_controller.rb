class HolidaysController < ApplicationController
  #before_action :set_holiday, except: [:index, :new, :create, :destroy]
  #respond_to :html
  def index
    @holidays = Holiday.all
    respond_to do |format|
      format.html
      if(params[:param] == "param")
      format.csv { send_data @holidays.to_csv2 }
    else
        format.csv { send_data @holidays.to_csv }
    end
      format.xls
    end
  end

  def new
    @holiday = Holiday.new
    respond_to do |format|
      format.js
    end
  end

  def import
  Holiday.import(params[:file])
  redirect_to holidays_path(:id => params[:id])
  end

  def create
    #base_date = params[:holiday][:start].split("/")
    #@start = params[:holiday][:start] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
    #base_date = params[:holiday][:end].split("/")
    #@end = params[:holiday][:end] = base_date[2] + "-" + base_date[1] + "-" + base_date[0]
    @mandays = (Date.parse(params[:holiday][:end])-Date.parse(params[:holiday][:start])).to_i
    @holiday = Holiday.new(holiday_params.merge(start: change_date_format, :end => change_date_format2, annual_leave: params[:annual_leave] == "true", :mandays => @mandays ))
    respond_to do |format|
        format.js
      end
  end

  def change_date_format
    if params[:holiday].present?
      if params[:holiday][:start].present?
        base_date = params[:holiday][:start].split("/")
        params[:holiday][:start] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

    def change_date_format2
    if params[:holiday].present?
      if params[:holiday][:end].present?
        base_date = params[:holiday][:end].split("/")
        params[:holiday][:end] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

  def edit
    @holiday = Holiday.find_by_id(params[:id])
    respond_to do |format|
      format.js
      end
  end

  def update
    @mandays = (Date.parse(params[:holiday][:end])-Date.parse(params[:holiday][:start])).to_i
    @holiday = Holiday.find_by_id(params[:holiday][:id])
    @holiday.update_attributes(holiday_params.merge(:mandays => @mandays,  annual_leave: params[:annual_leave] == "true"))
    respond_to do |format|
        format.js
      end
  end

  def destroy   
    params[:check].each do |delete|
      Holiday.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end
    end

 private
    def set_role
      
      @holiday = Holiday.find(params[:id])
    end

    def set_roles
      base_holiday = Holiday.all
      @holidays_count = base_holiday.count
      @holidays = base_holiday.paginate(:page => params[:page])
    end

    def holiday_params
      params.require(:holiday).permit(:name, :start, :end, :mandays, :holiday_type_id)
    end
end