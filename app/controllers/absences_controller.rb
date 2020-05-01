class AbsencesController < ApplicationController
	before_action :set_date
	before_action :set_permition, only: [:permition]
	before_action :set_check_in, only: [:check_in]
	before_action :set_check_out, only: [:check_out]
	# before_action :set_params, only:[:check_in, :check_out]
  	
  	def index
		absences_today = Absence.where(date: Time.now.strftime('%Y-%m-%d'))
		@absences = absences_today.where(status: 'enter')
	    # @absences = base_absence.paginate(:page => params[:page])
	    @absences_overdue = @absences.where("overtime is NOT NULL and overtime != ''")
	    @alphas = Absence.alphas(current_company, absences_today)
	    @permition = Absence.new
	end

	def check_in
		employee = current_user.employee
		absence = employee.absences.build(absence_params).save
		redirect_to :action => 'index'
	end

	def check_out
		absence = current_user.employee.absences.last.update(absence_params)
		redirect_to :action => 'index'
	end


	def permition
		params[:permit].each do |permit|
			Employee.find_by_id(permit.to_i).absences.build(permit_params).save
		end
		redirect_to :action => 'index'
	end


	private
	    def absence_params
	    	params.require(:absence).permit(:date, :check_in, :check_out, :overtime, :status)
	    end

	    def permit_params
	    	params.require(:absence).permit(:date)
	    end

	    def set_date
	    	@time_now = Time.now
	    	params[:absence] = {} if params[:absence].blank?
	    end

	    def set_permition
	    	params[:absence][:date] = @time_now.strftime('%Y-%m-%d')
	    	params[:absence][:status] = 'permit'
	    end

	    def set_check_in
	    	params[:absence][:date] = @time_now.strftime('%Y-%m-%d')
	    	params[:absence][:check_in] = @time_now.strftime('%T')
	    	params[:absence][:status] = 'enter'
	    	time_parse = @time_now.strftime('%T').split(':')
	    	time_second = time_parse[0].to_i * 3600 + time_parse[1].to_i * 60 + time_parse[2].to_i
	    	if time_second > 32400
	    		time_second = time_second - 32400
	    		params[:absence][:overtime] = (time_second / 3600).to_s + ':' + (time_second % 3600 / 60).to_s + ':' + (time_second % 3600 % 60).to_s
	    	end
	    end

	    def set_check_out
	    	params[:absence][:check_out] = @time_now.strftime('%T')
	    end

end
