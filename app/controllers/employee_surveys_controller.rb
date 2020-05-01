class EmployeeSurveysController < ApplicationController
	def index
  
	 @employee_surveys = EmployeeSurvey.where(:employee_id => params[:id])
    respond_to do |format|
        format.html
    end
	end

	def new
   @employee = Employee.find_by_id(params[:id])
   @employee_survey = EmployeeSurvey.new
   @admin_survey = AdminSurvey.where(:status => "1")
	end

	def create
    #raise EmployeeSurvey.inspect
#    @employee_survey = EmployeeSurvey.new(employee_survey_params.merge(content_datepicker: change_date_format ))    
#    @employee_survey.save
    params[:admin_survey_id].each{|admin_survey|
      EmployeeSurvey.create(employee_id: params[:employee_survey][:employee_id], admin_survey_id: admin_survey[0],
        content_textbox: params[:content_textbox][admin_survey[0]], content_textarea: params[:content_textarea][admin_survey[0]],
        content_datepicker: custom_date_format(params[:content_datepicker][admin_survey[0]]))
    }
    redirect_to edit_employee_path(params[:employee_survey][:employee_id])
  end

  def custom_date_format date_param
    if date_param.present?
      if date_param.present?
        base_date = date_param.split("/")
        paramsdate_param = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

  def change_date_format
    if params[:employee_survey].present?
      if params[:employee_survey][:content_datepicker].present?
        base_date = params[:employee_survey][:content_datepicker].split("/")
        params[:employee_survey][:content_datepicker] = base_date[0] + "-" + base_date[2] + "-" + base_date[1]
      end
    end
  end

  private
    def employee_survey_params
      params.require(:employee_survey).permit(:content_textbox, :content_textarea, :content_datepicker, :admin_survey_id, :employee_id)
    end
end
