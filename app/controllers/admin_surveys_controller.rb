class AdminSurveysController < ApplicationController
  def index
    @admin_surveys = AdminSurvey.all
    @admin_survey = AdminSurvey.new
  end
  def create
    @admin_survey = AdminSurvey.new(admin_survey_params)    
    @admin_survey.save
    redirect_to admin_surveys_path
  end

  def edit
    @admin_survey = AdminSurvey.find_by_id(params[:id])
  end
  def update
    @admin_survey = AdminSurvey.find_by_id(params[:id])
    @admin_survey.update(admin_survey_params)
    redirect_to admin_surveys_path
    
  end

  def destroy   
    params[:check].each do |delete|
      AdminSurvey.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end
    end

  private
    def admin_survey_params
      params.require(:admin_survey).permit(:question_title, :question_type, :status)
    end
end
