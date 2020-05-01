class ShiftsController < ApplicationController
  before_action :set_shifts, except: [:index, :new, :create, :destroy]
  respond_to :html
  def index
  	@shifts = Shift.all
    
  end

  def show
  	@shift = Shift.find (params[:id])
  end

  def new
  	@shift =Shift.new
  end

def create
    @shift = Shift.new(shift_params)
    if @shift.save
      respond_to do |format|
        format.html { redirect_to shifts_path }
        format.js { render :create }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :create }
      end
    end
   
  end


  def edit
    @shift = Shift.find(params[:id])
  end

  def update
  	if @shift.update(shift_params)
      respond_to do |format|
        format.html { redirect_to shifts_path }
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
  	@shift = Shift.find(params[:id])
    @shift.destroy
    redirect_to shifts_path, :notice => "Your Shift has been deleted"
  end

 private
    def set_shift
      
      @shift = Shift.find(params[:id])
    end

    def set_shifts
      base_shift = Shift.all
      @shifts_count = base_shift.count
      @shifts = base_shift.paginate(:page => params[:page])
    end

    def shift_params
      params.require(:shift).permit(:code, :name)
    end
end