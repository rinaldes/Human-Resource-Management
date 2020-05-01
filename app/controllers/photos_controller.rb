class PhotosController < ApplicationController
  before_action :find_photo_by_id, only: [:show, :edit, :update, :destroy]
  before_action :get_organizations
  before_action :get_photo_activities
  autocomplete :organization, :name
  autocomplete :photo_activity, :name

  def index
    @photos = Photo.joins(:user).where("users.company_id=#{@current_user.company_id}").paginate(page: params[:page], per_page: 100)
    @photos_count = Photo.joins(:user).where("users.company_id=#{@current_user.company_id}").select("count(*) AS photos_count")[0].photos_count
  end

  def new
    @photo = Photo.new
  end

  def destroy
    @photo.destroy
    flash[:notice] = 'Successfully Deleted'
    redirect_to photos_url
  end

  def show
    @photo_comment = PhotoComment.new
    @comments = @photo.photo_comments
  end

  def comment
    @photo_comment = PhotoComment.new(comment_params.merge(photo_id: params[:id], user_id: current_user.id))
    @photo_comment.save
    redirect_to action: 'show'
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params.merge(created_by: @current_user.id))
    if @photo.save
      receiver_photo = params[:photo][:organization_id].first.split(",")
      receiver_photo.each do |organization|
        organization = Organization.find_by_name(organization)
        PhotoReceiver.create(organization_id: organization.id, photo_id: @photo.id) if organization.present?
      end
     redirect_to :action => 'index'
    else
      format.html { render :new }
      format.json { render json: @photo.errors, status: :unprocessable_entity }
    end
  end

  def update
     @photo.photo_receivers.destroy_all
     if @photo.update(photo_params.merge(updated_by: @current_user.id))
       receiver_photo = params[:photo][:organization_id].first.split(",")
       receiver_photo.each do |organization|
         organization = Organization.find_by_name(organization)
         PhotoReceiver.create(organization_id: organization.id, photo_id: @photo.id) if organization.present?
       end
       redirect_to action: 'show'
     else
       format.html { render :new }
       format.json { render json: @photo.errors, status: :unprocessable_entity }
     end
  end

  def destroy
   @photo.photo_receivers.destroy_all
   @photo.destroy
   redirect_to action: 'index'
  end

  def autocomplete_organization
    render json: Organization.where("Lower(name) like '%#{params[:term].downcase}%'").map { |organization| {value: organization.name.to_s, text: organization.name.to_s} }
  end

  def get_organizations
    @organizations = Organization.all.map { |e| [e.name, e.id] }
  end

  def autocomplete_photo_activity_name
    render json: PhotoActivity.where("Lower(name) like '%#{params[:term].downcase}%'").map { |photo_activity| {value: photo_activity.name.to_s, text: photo_activity.name.to_s} }
  end

  def get_photo_activities
    @photo_activities = PhotoActivity.all.map { |e| [e.name, e.id] }
    
  end

private
  def photo_params
    params.require(:photo).permit(:caption, :image, :histories, :organization_id, :photo_activity_id)
  end

  def comment_params
    params.require(:photo_comment).permit(:comment)
  end

  def find_photo_by_id
    @photo =Photo.find_by_id(params[:id])
  end
end