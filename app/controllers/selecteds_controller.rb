class SelectedsController < ApplicationController
	def index
    @selecteds = Selected.all
  end

  def new
    @selected = Selected.new
  end

  def create 
    @selected = Selected.new(selected_params)
    respond_to do |format|
      if @selected.save
        format.html { redirect_to(@selecteds, :notice => 'Data was successfully created.')}
        format.xml  { render :xml => @selected, :status => :created, :location => @selected }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @selected.errors, :status => :unprocessable_entity }
      end
    end
  end

  def selected_params
      params.require(:selected).permit(:Aplicant_Name, :Attachment, :Apply_for_Position, :Interview_Resul, :Status_Interview)
    end
end
