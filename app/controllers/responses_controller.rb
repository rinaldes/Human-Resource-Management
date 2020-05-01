class ResponsesController < ApplicationController
  before_action :authenticate_admin
  
  def index
  	if params[:survey].present?
  		@survey = Survey.new(survey_params)
  		
  		params_survey = params[:survey]
	  	
	  	params_name = params_survey[:name].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

	  	params_period_start = change_format(params_survey[:period_start]) if params_survey[:period_start].present?
	  	params_period_end = change_format(params_survey[:period_end]) if params_survey[:period_end].present?
	  	params_status = params_survey[:status].upcase unless params_survey[:status] == "all"

	  	puts params_period_start

	    where_clauses = []
	    where_clauses << "UPPER(name) LIKE '%#{params_name}%'" if params_name.present?
	    where_clauses << "period_start >= '#{params_period_start}'" if params_period_start.present?
	    where_clauses << "period_end <= '#{params_period_end}'" if params_period_end.present?
	    where_clauses << "UPPER(status) = '#{params_status}'" if params_status.present?

	    base_survey = Survey.where(where_clauses.join(" AND "))
  	else
  		@survey = Survey.new
    	base_survey = Survey.all
  	end

    @surveys_count = base_survey.count
    @surveys = base_survey.paginate(:page => params[:page])

    @send_survey = Survey.find(params[:id]) if params[:id].present?

    respond_to do |format|
      format.html
      format.js
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @send_survey.name + " on " + DateTime.now.strftime("%d %B %Y %T").to_s + '.xls"'
      end
    end
  end

  private
    def survey_params
      params.require(:survey).permit(:name, :period_start, :period_end, :status)
    end

    def change_format(date)
    	dates = date.split("/")
    	return dates[2] + "-" + dates[0] + "-" + dates[1]
    end
end
