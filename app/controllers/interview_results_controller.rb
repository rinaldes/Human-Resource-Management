class InterviewResultsController < ApplicationController

	def index
		@interview_results = InterviewResult.where(:recruitment_id => params[:recruitment_id])
	end

  def new
    @interview_result = InterviewResult.new
  end

  def show
    @interview_result = InterviewResult.find_by_id(params[:id])
  end

  def create
    @interview_result = InterviewResult.new(interview_result_params)
    respond_to do |format|
        format.js
      end
  end

  def destroy
    params[:check].each do |delete|
      InterviewResult.find_by_id(delete).destroy
    end
    respond_to do |format|
        format.js
      end
  end

  def edit
    @interview_result = InterviewResult.find_by_id(params[:id])
  end

  def update
    interview_result = InterviewResult.find_by_id(params[:id])
    interview_result.update(interview_result_params)
    respond_to do |format|
        format.js
      end
  end

  def update_status
    interview_result = InterviewResult.find_by_id(params[:id])
    if params[:commit] == "Yes"
      interview_result.update(:status => "Selected")
    else
      interview_result.update(:status => "Not Qualify")
    end
    respond_to do |format|
        format.js
      end
  end

  private
  def interview_result_params
    params.require(:interview_result).permit(:test_result_id , :interview_result, :status, :recruitment_id)
  end

end
