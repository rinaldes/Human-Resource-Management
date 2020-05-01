class GoalValuesController < ApplicationController

def index
    @goal_values = GoalValue.all
    @goal_values_count = @goal_values.count
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @goal_values.to_csv2 }
      else
        format.csv { send_data @goal_values.to_csv }
      end
    end
  end

  def search
     params_value = params[:value].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

    where_clauses = []
    where_clauses << "UPPER(value) LIKE '%#{params_value}%'" if params_value.present?    

    @goal_values = GoalValue.where(where_clauses.join(" AND "))
    @goal_values_count = @goal_values.count
    render :index
  end
  def new
    @goal_value = GoalValue.new
    respond_to do |format|
      format.js
    end
  end

  def import
    GoalValue.import(params[:file])
    redirect_to goal_values_path, notice: "Value imported."
  end

  def create 
    @goal_value = GoalValue.new(goal_value_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      GoalValue.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end

  end

  def edit
    @goal_value = GoalValue.find_by_id(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update_goal_value
    @goal_value = GoalValue.find_by_id(params[:goal_value][:id])
    @goal_value.update_attributes(goal_value_params)
    respond_to do |format|
        format.js
      end   
  end

  def show
  end

  private
    def set_goal_values
        base_goal_value = GoalValue.all
        @goal_values_count = base_goal_value.count
        @goal_values = base_goal_value.paginate(:page => params[:page])
    end

    def goal_value_params
      params.require(:goal_value).permit(:value)
    end

    def set_goal_value
      @goal_value = GoalValue.find(params[:id])
    end
end