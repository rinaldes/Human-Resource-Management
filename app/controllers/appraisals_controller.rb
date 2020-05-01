class AppraisalsController < ApplicationController
	before_action :set_appraisal, only: [:show, :edit, :update, :destroy]
  	before_action :set_appraisals
	autocomplete :goal, :goal
	autocomplete :goal_value, :value

	def index
		@fields = Appraisal.column_names
	    filename = 'List Users on ' + DateTime.now.strftime("%d %B %Y %T").to_s
	    # respond_to do |format|
	    #   format.html
	    #   format.js
	    #   format.csv { send_data @appraisals.to_csv, filename: filename + '.csv'}
	    #   format.xls do
	    #     response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
	    #   end
	    # end
	end

	def show
		@appraisal = Appraisal.find_by_id(params[:id])
	end

	def new
		@appraisal = Appraisal.new
		@goals = Goal.all
		@values = GoalValue.all
	end

	def create
		@appraisal = Appraisal.new(appraisal_params)
	    respond_to do |format|
	    	format.js
	      if @appraisal.save
	        format.html { redirect_to(@appraisal, :notice => 'Appraisal was successfully created.') }
	        format.xml  { render :xml => @appraisal, :status => :created, :location => @appraisal }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @appraisal.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def destroy
		params[:check].each do |delete|
			Appraisal.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@appraisal = Appraisal.find_by_id(params[:id])
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_appraisal
		@appraisal = Appraisal.find_by_id(params[:appraisal][:id])
		@appraisal.update(appraisal_params)
		respond_to do |format|
	      format.js
	    end
	end

	def autocomplete_goal
		render json: Goal.where("goal like '%#{params[:term]}%'").map { |goal| {label: goal.goal.to_s, value: goal.goal.to_s} }
	end

	def autocomplete_goal_value
		render json: GoalValue.where("value like '%#{params[:term]}%'").map { |goal_value| {label: goal_value.value.to_s, value: goal_value.value.to_s} }
	end

	def get_value

		@employee = Employee.find_by_name(params[:name])
		respond_to do |format|
			format.js
		end
	end

	def goal
		@goal = AppraisalGoal.new
			respond_to do |format|
				format.js
			end
	end

	def value
		@value = AppraisalValue.new
			respond_to do |format|
				format.js
			end
	end

	private
	    def set_appraisal
	      @appraisal = Appraisal.find(params[:id])
	    end

	    def set_appraisals
	      base_appraisal = Appraisal.all
	      @appraisals_count = base_appraisal.count
	      @appraisals = base_appraisal.paginate(:page => params[:page])
	    end

	    def appraisal_params
	    	params.require(:appraisal).permit(:employee_id, :evaluator, :start_periode, :end_period, :total_score, :goal, :value, :bobot2, appraisal_components_attributes: [:id, :_destroy, :component, :bobot, :goal, :value, :bobot2, appraisal_component_indikators_attributes: [:id, :_destroy, :indikator, :archivement, :score, :appraisal_goals_attribute [:id, :goal, :bobot, :appraisal_values_attribute, [:id, :value, :bobot]]]])
	    end
end
