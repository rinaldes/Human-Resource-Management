class GoalsController < ApplicationController

def index
    @goals = Goal.all
    @goals_count = @goals.count
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @goals.to_csv2 }
      else
        format.csv { send_data @goals.to_csv }
      end
    end
  end

  def search
     params_goal = params[:goal].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

    where_clauses = []
    where_clauses << "UPPER(goal) LIKE '%#{params_goal}%'" if params_goal.present?    

    @goals = Goal.where(where_clauses.join(" AND "))
    @goals_count = @goals.count
    render :index
  end

  def new
  	@goal = Goal.new
    respond_to do |format|
      format.js
    end
  end

  def import
    Goal.import(params[:file])
    redirect_to goals_path, notice: "Goal imported."
  end

  def create 
    @goal = Goal.new(goal_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      Goal.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end

  end

  def edit
    @goal = Goal.find_by_id(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update
    @goal = Goal.find_by_id(params[:goal][:id])
    @goal.update(goal_params)
    respond_to do |format|
        format.js
      end   
  end

  def show
  end

  private
	  def set_goals
	      base_goal = Goal.all
	      @goals_count = base_goal.count
	      @goals = base_goal.paginate(:page => params[:page])
	  end

    def goal_params
      params.require(:goal).permit(:goal)
    end

    def set_goal
      @goal = Goal.find(params[:id])
    end
end
