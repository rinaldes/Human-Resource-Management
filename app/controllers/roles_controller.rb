class RolesController < ApplicationController
  before_action :set_role, except: [:index, :new, :create, :destroy]
  respond_to :html

  def index
    conditions_or = []
    ["name"].each{|f|
      conditions_or << "#{f} LIKE '%#{params[:search][:search]}%'"
    } if params[:search].present?
    @roles = Role.where(conditions_or.join(' OR ')).paginate(page: params[:page], per_page: 100)
    @roles_count = Role.where(conditions_or.join(' OR ')).count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  	@role = Role.find (params[:id])
  end

  def new
  	@role =Role.new
    @feature_names = FeatureName.all
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      params[:role][:feature].each do |feat|
        feat = feat.split(',')
        feature = @role.features.build(feature_name_id: feat[0].to_i)
        feature.save
        feature.build_feature_group(name: feat[1]).save
      end
    else

    end
    # if @role.save
    #   respond_to do |format|
    #     format.html { redirect_to roles_path }
    #     format.js { render :create }
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render :index }
    #     format.js { render :create }
    #   end
    # end
    # respond_with(@role)
  end


  def edit
    @role = Role.find(params[:id])
    @feature_names = FeatureName.all
  end

  # def update
  # 	if @role.update(role_params)
  #     respond_to do |format|
  #       format.html { redirect_to roles_path }
  #       format.js { render :update }
  #     end
  #   else
  #     respond_to do |format|
  #       format.html { render :index }
  #       format.js { render :update }
  #     end
  #   end
  # end

  def update
    if @role.update(role_params)
      @role.features.destroy_all
      params[:role][:feature].each do |feat|
        feat = feat.split(',')
        feature = @role.features.build(feature_name_id: feat[0].to_i)
        feature.save
        feature.build_feature_group(name: feat[1]).save
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :update }
      end
    end
  end

  def destroy
  	@role = Role.find(params[:id])
    @role.destroy
    redirect_to roles_path, :notice => "Your Role has been deleted"
  end

 private
    def set_role
      
      @role = Role.find(params[:id])
    end

    def set_roles
      base_role = Role.all
      @roles_count = base_role.count
      @roles = base_role.paginate(:page => params[:page])
    end

    def role_params
      params.require(:role).permit(:name)
    end
end
