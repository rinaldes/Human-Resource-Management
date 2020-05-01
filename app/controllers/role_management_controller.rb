class RoleManagementController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create]
	before_filter :find_asset, only: [:edit, :update, :destroy, :show]

	def index
	   @role_managements_count = RoleManagement.role_managements_count(params)
	   @per_page = params[:per_page] == ALL ? @role_managements_count : params[:per_page] ? params[:per_page].to_i : DEFAULT_PER_PAGE
	  # @role_managements =  RoleManagement.role_managements_list(params).page(params[:page]).per(@per_page)
	   @role_managements = RoleManagement.role_managements_list(params).paginate(:page => params[:page], :per_page => 100)
	end
	
	def new
		@question_type = ['TextBox', 'Yes/No', 'TextBox With Text', 'Paragraph Text', 'Dropdown', 'Radio Button', 'Check Boxes', 'Ranking', 'Radio Button Grid', 'CheckBox Grid', 'TextBox Grid', 'Percentage Scale', 'Radio Button Scale', 'Date', 'Time', 'Upload', 'Header Text']
  		@role_management = RoleManagement.new
	end


	def submit_question
		if session[:question].blank?
			session[:question] = []
		end
		session[:question] << params[:question]
		respond_to do |format|
	      format.js
   		end
	end

	def create
		role_management = RoleManagement.new(role_management_params)
		if role_management.save
			session[:question].each do |question|
				role_management_question = role_management.role_management_questions.build(:title => question['title'], :help => question['help'], :question_type => question['type'], :question_varians => [question['nilai']['row'], question['nilai']['column']])
				role_management_question.save
			end
			session[:question].clear
		end
		redirect_to role_managements_path
	end


  def find_role_management
    @role_management = RoleManagement.find(params[:id])
  end

  private

	  def role_management_params
	    params.require(:role_management).permit(:name, :description, :period_start, :period_end, :status, :back_page_url, :disclaimer)
	  end

	  # def role_management_question_session
	  # 	debugger
	  #   question.permit(:title, :help, :type, :question_varians)
	  # end




end
