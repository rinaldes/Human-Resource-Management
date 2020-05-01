class LanguageSkillsController < ApplicationController
	
	def index
		@language_skills = LanguageSkill.where(:employee_id => params[:id])
	 	#@fields = LanguageSkill.column_names
    #filename = 'List language skills on ' + DateTime.now.strftime("%d %B %Y %T").to_s
		respond_to do |format|
        format.html
        #format.js
        format.csv { send_data @language_skills.to_csv(params) }
        format.xls do
          #response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
        end
      end
	end

	def import
	  LanguageSkill.import(params[:file])
	   redirect_to employee_working_datas_path(:id => params[:id]), notice: "Imported success."
		end

	def new

		@language_skill = LanguageSkill.new
	  	respond_to do |format|
	    	format.js
		end
	end

		def create
		@language_skill = LanguageSkill.new(language_skill_params)
		respond_to do |format|
	      format.js
	    end
	end
	def destroy
		params[:check].each do |delete|
			LanguageSkill.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@language_skill = LanguageSkill.find_by_id(params[:id])
	  	respond_to do |format|
	    	format.js
		end
	end

	def update_language_skill
		@language_skill = LanguageSkill.find_by_id(params[:language_skill][:id])
		@language_skill.update(language_skill_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def language_skill_params
			params.require(:language_skill).permit(:language, :reading, :writing, :speaking, :employee_id)
		end
end