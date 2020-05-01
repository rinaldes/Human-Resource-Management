class ComponentsController < ApplicationController
  def index
  	@components = Component.all
    @indicators = Indicator.all
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @components.to_csv2 }
      else
        format.csv { send_data @components.to_csv }
      end
    end
  end

  def new
  	@component = Component.new
    respond_to do |format|
      format.js
    end
  end

  def import
    Component.import(params[:file])
    redirect_to components_path, notice: "Component imported."
  end

  def create
    @component = Component.new(component_params.merge(indicator: fieldnya_indicator))
    respond_to do |format|
      format.js
    end
  end

  def fieldnya_indicator
    indi = ""
    if params[:component].present?
      if params[:component][:indicator].present?
        params[:component][:indicator].split("\n").each do |line|
          indi +=  line
          indi +=  ";"
        end
        params[:component][:indicator] = indi
      end
    end
  end 

  def destroy
    params[:check].each do |delete|
      Component.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end

  end

  def edit
    @component = Component.find_by_id(params[:id])
    @indicatornya = ""
    if @component.indicator.present?
      @component.indicator.split(";").each do |line|
        @indicatornya += line
        @indicatornya += "\n"
      end
    end
    respond_to do |format|
        format.js
      end
  end

  def update
    @component = Component.find_by_id(params[:component][:id])
    @component.update_attributes(component_params.merge(indicator: fieldnya_indicator))
    respond_to do |format|
        format.js
      end   
  end

  private
	  def set_components
	      base_component = Component.all
	      @components_count = base_component.count
	      @components = base_component.paginate(:page => params[:page])
	  end

    def component_params
      params.require(:component).permit(:id, :name, :indicator)
    end

    def set_component
      @component = Component.find(params[:id])
    end
end
