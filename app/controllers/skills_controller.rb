class SkillsController < ApplicationController

def index
		@skills = Skill.where(:employee_id => params[:id])
		#@fields = PositionDetail.column_names
    #filename = 'List position details on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
				format.csv { send_data @skills.to_csv(params) }
        #format.template { send_data @performances.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
	end

	def import
  Skill.import(params[:file])
  rredirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
	end

	def new

		@skill = Skill.new
	  	respond_to do |format|
	    	format.js
		end
	end

	def create
		@skill = Skill.new(skill_params)
		respond_to do |format|
	      format.js
	    end
	end

	def destroy
		params[:check].each do |delete|
			Skill.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@skill = Skill.find_by_id(params[:id])
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_skill
		@skill = Skill.find_by_id(params[:skill][:id])
		@skill.update(skill_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def skill_params
			params.require(:skill).permit(:skill_type, :employee_id)
		end
end