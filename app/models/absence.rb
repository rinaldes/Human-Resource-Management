class Absence < ActiveRecord::Base
	self.per_page = 20
	belongs_to :employee
	
	def self.set_per_page(number)
    	self.per_page = number
    end

    def self.alphas(current_company, absenced)
    	date_now = Time.now.strftime('%Y-%m-%d')
    	absenced = absenced.map{|x| x.employee.id}
    	alphas = current_company.employees.joins(:schedules).where("schedules.start_period < ? and schedules.end_period > ?", date_now, date_now)
    	alphas = alphas.where.not(:id => absenced.first) if absenced.count == 1
    	alphas = alphas.where.not(:id => absenced) if absenced.count > 1
    	return alphas
    end

    def self.get_employee_absence(params)
    	absences = Employee.find_by_id(params[:id]).absences
    	absences = absences.where('extract(month from date) = ?', params[:month].to_i) if params[:month].present?
    	absences = absences.where('extract(year from date) = ?', params[:year].to_i) if params[:year].present?
    	return {enter: absences.where(:status => 'enter').count, permit: absences.where(:status => 'permit').count}
    end
end
