class HolidayTypesController < ApplicationController

  def index
    conditions_or = []
    ['code', "name"].each{|f|
      conditions_or << "LOWER(#{f}) LIKE LOWER('%#{params[:search][:search]}%')"
    } if params[:search].present?
    @holiday_types = HolidayType.where(conditions_or.join(' OR ')).paginate(page: params[:page], per_page: 100)
    @holiday_types_count = HolidayType.where(conditions_or.join(' OR ')).count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @holiday_type = HolidayType.find (params[:id])
  end

  def new
    @holiday_type = HolidayType.new
  end

  def create
    @holiday_type = HolidayType.new(holiday_type_params)
    respond_to do |format|
        format.js
    end
  end

  def edit
    @holiday_type = HolidayType.find_by_id(params[:id])
    respond_to do |format|
        format.js
    end
  end

  def update_holiday_type
    @holiday_type = HolidayType.find_by_id(params[:holiday_type][:id])
    @holiday_type.update(holiday_type_params)
    respond_to do |format|
        format.js
      end
  end

  def destroy
    params[:check].each do |delete|
      HolidayType.find_by_id(delete).destroy
    end
    respond_to do |format|
      format.js
    end
  end


  

 private
    def set_holiday_type
      
      @holiday_type = HolidayType.find(params[:id])
    end

    def set_holiday_types
      base_holiday_type = HolidayType.all
      @holiday_types_count = base_holiday_type.count
      @holiday_types = base_holiday_type.paginate(:page => params[:page])
    end

    def holiday_type_params
      params.require(:holiday_type).permit(:name, :code, :as_leave )
    end

end
