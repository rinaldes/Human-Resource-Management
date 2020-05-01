class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:index, :new, :create, :destroy]
  respond_to :html
  def index
    @organizations = Organization.all
    position_index
  end

  def show
    @organization = Organization.find (params[:id])
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params.merge(company_id: current_user.company_id))
    respond_to do |format|
      format.js
    end
  end

 def edit
    @organization = Organization.find(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update
    @organization = Organization.find_by_id(params[:organization][:id])
    @organization.update(organization_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      Organization.find_by_id(delete).destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def position_index
    @positions = Position.all
    
  end

  def position_show
    @position = Position.find (params[:id])
  end

  def position_new
    @position = Position.new
  end
  
def position_create
   @position = Position.new(position_params)
    respond_to do |format|
        format.js
      end
    # @position = Position.new(position_params)
    # if @position.save
    #   respond_to do |format|
    #     format.html { redirect_to organizations_path }
    #     format.js { render :createposition }
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render :index }
    #     format.js { render :createposition }
    #   end
    # end
    # respond_with(@role)
  end


  def position_edit
      @position = Position.find(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def position_update
    @position = Position.find_by_id(params[:position][:id])
    @position.update(position_params)
    respond_to do |format|
        format.js
      end
  end

  def position_destroy
   params[:check].each do |delete|
      Position.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end
  end
 private
    def set_organization
      
      @organization = Organization.find(params[:id])
    end

    def set_organization
      base_organization = Organization.all
      @organizations_count = base_organization.count
      @organizations = base_organization.paginate(:page => params[:page])
    end

    def organization_params
      params.require(:organization).permit(:organization_parent, :name, :company_id)
    end

     def set_position
      
      @position = Position.find(params[:id])
    end

    def set_position
      base_position = Position.all
      @positions_count = base_position.count
      @positions = base_position.paginate(:page => params[:page])
    end

    def position_params
      params.require(:position).permit(:name, :leave_time)
    end
end