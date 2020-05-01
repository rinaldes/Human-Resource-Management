class FamiliesController < ApplicationController

	def index
		@families = Family.where(:employee_id => params[:employee_id])
		@employee = Employee.find_by_id(params[:id])
	end

	def new
		@family = Family.new
		@status = ['Ayah', 'Ibu', 'Kakak', 'Adik', 'Istri', 'Suami', 'Anak']
	    respond_to do |format|
	      format.js
	    end
	end

	def create
		@family = Family.new(family_params)
		respond_to do |format|
	      format.js
	    end
	end

	def destroy
		params[:check].each do |delete|
			Family.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@family = Family.find_by_id(params[:id])
		@status = ['Ayah', 'Ibu', 'Kakak', 'Adik', 'Istri', 'Suami', 'Anak']
		respond_to do |format|
	      format.js
	    end
	end

	def update_family
		@family = Family.find_by_id(params[:family][:id])
		@family.update(family_params)
		respond_to do |format|
	      format.js
	    end
	end

	private
		def family_params
			params.require(:family).permit(:status, :name, :address, :education, :work, :birthday, :employee_id)
		end
end
