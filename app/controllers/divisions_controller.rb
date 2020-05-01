class DivisionsController < ApplicationController
	before_action :set_division, except: [:index, :new, :create, :destroy]
  respond_to :html
  def index
  	@divisions = Division.all
    
  end

  def new
  	@division =Division.new
  end

def create
    @division = Division.new(division_params)
    if @division.save
      respond_to do |format|
        format.html { redirect_to divisions_path }
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


  def edit
    @division = Division.find(params[:id])
  end

  def update
  	if @division.update(division_params)
      respond_to do |format|
        format.html { redirect_to divisions_path }
        format.js { render :update }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :update }
      end
    end
  end

  def destroy
  	@division = Division.find(params[:id])
    @division.destroy
    redirect_to divisions_path, :notice => "Your Division has been deleted"
  end

 private
    def set_division
      
      @division = Division.find(params[:id])
    end

    def set_divisions
      base_role = Division.all
      @roles_count = base_role.count
      @roles = base_role.paginate(:page => params[:page])
    end

    def division_params
      params.require(:division).permit(:name, :description)
    end
end

