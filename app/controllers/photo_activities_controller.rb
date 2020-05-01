class PhotoActivitiesController < ApplicationController
  def index
    @photo_activities = PhotoActivity.where("company_id=#{@current_user.company_id}").paginate(page: params[:page], per_page: 100)
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @photo_activities.to_csv2 }
      else
        format.csv { send_data @photo_activities.to_csv }
      end
    end
  end

  def new
    @photo_activity = PhotoActivity.new
    respond_to do |format|
      format.js
    end
  end

  def import
    PhotoActivity.import(params[:file])
    redirect_to categories_path, notice: "PhotoActivity imported."
  end

  def create
    a = @current_user.id
    b = @current_company.id
    @photo_activity = PhotoActivity.new(photo_activity_params.merge(:company_id => b, :user_id => a))
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      PhotoActivity.find_by_id(delete).destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @photo_activity = PhotoActivity.find_by_id(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update
    @photo_activity = PhotoActivity.find_by_id(params[:photo_activity][:id])
    @photo_activity.update_attributes(photo_activity_params)
    respond_to do |format|
      format.js
    end
  end

  private
    def photo_activity_params
      params.require(:photo_activity).permit(:id, :name, :company_id, :user_id)
    end
end
