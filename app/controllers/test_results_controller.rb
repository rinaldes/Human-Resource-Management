class TestResultsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def index
		@test_results = TestResult.where(:recruitment_id => params[:recruitment_id])
		@test_result = TestResult.new
		respond_to do |format|
	      format.js
	    end
	end

	def new
		@test_result = TestResult.new
	end

	def show
		@test_result = TestResult.find_by_id(params[:id])
	end

	def create
		@test_result = TestResult.new(test_result_params)
		@test_result.save
      	redirect_to detail_recruitment_path(:id => params[:test_result][:recruitment_id])
	end

	def destroy
		params[:check].each do |delete|
			TestResult.find_by_id(delete).destroy
		end
		respond_to do |format|
	      format.js
	    end
	end

	def edit
		@test_result = TestResult.find_by_id(params[:id])
		respond_to do |format|
	      format.js
	    end
	end

	def update
		@test_result = TestResult.find_by_id(params[:test_result][:id])
		@test_result.update(test_result_params)
		respond_to do |format|
	      format.js
	    end
	end
	
	def update_status
    @test_result = TestResult.find_by_id(params[:id])
    if params[:commit] == "Yes"
      @test_result.update(:status => "interview")

      interview = InterviewResult.new(:recruitment_id => @test_result.recruitment_id , :test_result_id => params[:id] , :status => "pending")
      interview.save
    else
      @test_result.update(:status => "dismiss")
    end
    respond_to do |format|
        format.js
      end
	end

	def set_score
    @test_result = TestResult.find_by_id(params[:id])
    @test_result.update(test_result_params)
    respond_to do |format|
        format.js
      end
	end

	private
		def test_result_params
			params.require(:test_result).permit(:applicant_name, :attachment, :position_id, :score, :status, :email, :cv_status, :recruitment_id)
		end
end
