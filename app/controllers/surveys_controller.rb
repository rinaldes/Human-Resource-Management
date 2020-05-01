class SurveysController < ApplicationController
  before_action :authenticate_admin, except: [:index]
  before_action :new_survey
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :set_session

	# controller section
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

    respond_to do |format|
      format.html
      format.js
    end
	end

	def filter
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

    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
	end
	
	def new
		# session[current_user.id.to_s] = {}
	end

	def create
		# params[:survey][:period_start].to_date.strftime("%Y-%m-%d %H:%M:%S")
		# params[:survey][:period_start] = params[:survey][:period_start].to_date.strftime("%Y-%m-%d")
		# params[:survey][:period_end] = params[:survey][:period_end].to_date.strftime("%Y-%m-%d")
		
		default_period_start = params[:survey][:period_start]
		default_period_end = params[:survey][:period_end]

		params[:survey][:period_start] = change_format(params[:survey][:period_start])
		params[:survey][:period_end] = change_format(params[:survey][:period_end])

		first_date = params[:survey][:period_start].to_date
		end_date = params[:survey][:period_end].to_date
		today_date = Date.today()

		if first_date < today_date && end_date > today_date
			params[:survey][:status] = "open"
		else
			params[:survey][:status] = "closed"
		end

		current_session = session[current_user.id.to_s]
		temp_session_question = {}

		params[:survey][:user_id] = current_user.id
		# params[:survey][:name] = params[:survey][:name] + DateTime.now.to_s

		survey = Survey.new(survey_params)
		if survey.save
			current_session["pages"].each do |key, pages|
				if pages.present?
					survey_page = SurveyPage.new
					survey_page.survey_id = survey.id
					survey_page.title = pages["title"]
					survey_page.description = pages["description"]
					survey_page.background = pages["background"]
					survey_page.color = pages["color"]
					survey_page.order = pages["order"]
					survey_page.save

					if pages["question_order"].present?
						pages["question_order"].each do |index, question_id|
							if current_session["question"][question_id.to_i].present?
								question = current_session["question"][question_id.to_i]
								if current_session["logical"][question["id"].to_i].present?
									question["varians"] = question["varians"].merge(current_session["logical"][question["id"].to_i])
								end

								survey_question = SurveyQuestion.new
								survey_question.title = question["title"]
								survey_question.help = question["help"]
								survey_question.question_type = question["type"]
								survey_question.varians = question["varians"] #.to_a.to_s
								survey_question.is_required = question["required"].present? ? 1 : 0
								survey_question.answer = question["answer"].to_s
								survey_question.order = index
								survey_question.survey_page_id = survey_page.id
								survey_question.survey_id = survey.id
								survey_question.save

								temp_session_question[question_id.to_i] = question
								current_session["question"][question_id.to_i] = nil
							end
						end
					end
					# current_session["pages"][key] = {}
				end
			end

			current_session["question"].each do |key, question|
				if question.present?
					if current_session["logical"][question["id"].to_i].present?
						question["varians"] = question["varians"].merge(current_session["logical"][question["id"].to_i])
					end

					survey_question = SurveyQuestion.new
					survey_question.title = question["title"]
					survey_question.help = question["help"]
					survey_question.question_type = question["type"]
					survey_question.varians = question["varians"] #.to_a.to_s
					survey_question.is_required = question["required"].present? ? 1 : 0
					survey_question.answer = question["answer"].to_s
					survey_question.survey_id = survey.id
					survey_question.save
				end
			end

			session[current_user.id.to_s]["question"] = session[current_user.id.to_s]["question"].merge(temp_session_question)

			redirect_to reset_session_survey_path
		else
			params[:survey][:period_start] = default_period_start
			params[:survey][:period_end] = default_period_end

			render json: survey.errors
		end

		# render json: params
		# render json: session[current_user.id.to_s]
	end

	def update	
	end

	def edit	
	end

	def destroy
	end

	def show
		render layout: false
	end

	# question section
	def set_question
		last_record = session[current_user.id.to_s]['question'].values.last
		current_id = (last_record.present? ? last_record['id'].to_i : 0) + 1

		if params[:question].present?
			params[:question][:id] = current_id
			params[:question][:order] = current_id

			if params[:question][:varians].present?
				params[:question][:varians][:image] = upload_image(params[:question][:varians][:image]) if params[:question][:varians][:image].present?
				params[:question][:varians][:video] = upload_image(params[:question][:varians][:video]) if params[:question][:varians][:video].present?
			end

			session[current_user.id.to_s]['question'][current_id] = params[:question]

			# if params[:question][:varians].present?
			# 	if params[:question][:varians][:logical].present?
			# 		if params[:question][:varians][:logical] == 1
			# 			session[current_user.id.to_s]['logical'] << current_id
			# 		end
			# 	end
			# end
		end
		respond_to do |format|
      format.js
      format.html {redirect_to new_survey_path}
 		end
	end

	def edit_question
	end

	def add_question
	end

	def manage_question
		if params[:section] == "remove"
			if params[:id]
				if session[current_user.id.to_s]['question'][params[:id].to_i].present?
					session[current_user.id.to_s]['question'][params[:id].to_i] = nil

					session[current_user.id.to_s]['question'] = session[current_user.id.to_s]['question'].compact
				else
					@error = "unable to remove question!"
				end
			else
				@error = "unable to remove question!"
			end

		elsif params[:section] == "update"
			if params[:id]
				if session[current_user.id.to_s]['question'][params[:id].to_i].present?
					params[:question][:id] = params[:id]
					params[:question][:order] = params[:id]
					
					if params[:question][:varians][:image].present?
						params[:question][:varians][:image] = upload_image(params[:question][:varians][:image]) 
					else
						params[:question][:varians][:image] = session[current_user.id.to_s]['question'][params[:id].to_i]['varians']["image"]
					end
					
					if params[:question][:varians][:video].present?
						params[:question][:varians][:video] = upload_image(params[:question][:varians][:video])
					else
						params[:question][:varians][:video] = session[current_user.id.to_s]['question'][params[:id].to_i]['varians']["video"]
					end

					session[current_user.id.to_s]['question'][params[:id].to_i] = params[:question]
					# if params[:question][:varians].present?
					# 	if params[:question][:varians][:logical].present?
					# 		if params[:question][:varians][:logical] == 1
					# 			session[current_user.id.to_s]['logical'] << current_id
					# 		end
					# 	end
					# end
				else
					@error = "unable to update question!"
				end
			else
				@error = "unable to update question!"
			end

		elsif params[:section] == "duplicate"
			if params[:id]
				last_record = session[current_user.id.to_s]['question'].values.last
				@current_id = (last_record.present? ? last_record['id'].to_i : 0) + 1

				if session[current_user.id.to_s]['question'][params[:id].to_i].present?
					session[current_user.id.to_s]['question'][@current_id] = session[current_user.id.to_s]['question'][params[:id]]
					session[current_user.id.to_s]['question'][@current_id]["id"] = @current_id
				else
					@error = "unable to duplicate question!"
				end
			else
				@error = "unable to duplicate question!"
			end
			
		end

		respond_to do |format|
      format.js
      format.html {redirect_to new_survey_path}
 		end
	end

	# logical section
	def set_logical
		session[current_user.id.to_s]['logical'][params[:logical][:target].to_i] = params[:logical] if params[:logical].present?
		
		respond_to do |format|
      format.js
 		end
	end

	def edit_logical
	end

	def add_logical
	end

	def manage_logical
		if params[:section] == "remove"
			if params[:id]
				if session[current_user.id.to_s]['logical'][params[:id].to_i].present?
					session[current_user.id.to_s]['logical'][params[:id].to_i] = nil

					session[current_user.id.to_s]['logical'] = session[current_user.id.to_s]['logical'].compact
				else
					@error = "unable to remove logical workflow!"
				end
			else
				@error = "unable to remove logical workflow!"
			end

		elsif params[:section] == "update"
			if params[:id]
				if session[current_user.id.to_s]['logical'][params[:id].to_i].present?
					session[current_user.id.to_s]['logical'][params[:id]] = params[:logical] if params[:logical].present?
				else
					@error = "unable to update logical workflow!"
				end
			else
				@error = "unable to update logical workflow!"
			end
			
		end

		respond_to do |format|
      format.js
 		end
	end

	# page section
	def set_page
		last_record = session[current_user.id.to_s]['pages'].values.last
		current_id = (last_record.present? ? last_record['id'].to_i : 0) + 1

		if params[:pages].present?
			params[:pages][:id] = current_id
			params[:pages][:order] = current_id
			params[:pages][:question_order] = {}
			params[:pages][:questions].each_with_index do |id, index|
				params[:pages][:question_order][index+1] = id
			end

			session[current_user.id.to_s]['pages'][current_id.to_i] = params[:pages]
		end
		respond_to do |format|
      format.js
 		end
	end

	def edit_page
		set_options
	end

	def add_page
		set_options
	end

	def manage_page
		set_options
		params[:is_background] = params[:is_background].present? ? params[:is_background].to_s : 'false'

		if params[:section] == "remove"
			if params[:id]
				if session[current_user.id.to_s]['pages'][params[:id].to_i].present?
					
					if params[:is_background]=='true'
						session[current_user.id.to_s]['pages'][params[:id].to_i]['color'] = nil
						session[current_user.id.to_s]['pages'][params[:id].to_i]['background'] = nil
						session[current_user.id.to_s]['pages'][params[:id].to_i] = session[current_user.id.to_s]['pages'][params[:id].to_s].compact
					else
						session[current_user.id.to_s]['pages'][params[:id].to_i] = nil
						session[current_user.id.to_s]['pages'] = session[current_user.id.to_s]['pages'].compact
					end

				else
					@error = "unable to remove page!"
				end
			else
				@error = "unable to remove page!"
			end

		elsif params[:section] == "update"
			if params[:id]
				if session[current_user.id.to_s]['pages'][params[:id].to_i].present?
					params[:pages][:id] = params[:id]
					
					if params[:is_background]=='true'
						params[:pages][:background] = upload_image(params[:pages][:background]) if params[:pages][:background].present?
						session[current_user.id.to_s]['pages'][params[:id].to_i]['color'] = params[:pages]['color']
						session[current_user.id.to_s]['pages'][params[:id].to_i]['background'] = params[:pages]['background']
					else
						params[:pages][:order] = params[:id]
						params[:pages][:question_order] = {}
						params[:pages][:questions].each_with_index do |id, index|
							params[:pages][:question_order][index+1] = id
						end
						session[current_user.id.to_s]['pages'][params[:id].to_i] = params[:pages]
					end
				else
					@error = "unable to update page!"
				end
			else
				@error = "unable to update page!"
			end
		end

		respond_to do |format|
      format.js
 		end
	end

	# add on section
	def get_view
		render :partial => '/values/' + params[:view]
	end

	def reload
		respond_to do |format|
      format.js
 		end
	end

	def reorder
    str_id = params[:str_id].split("-")

    @render_view = str_id[0] + (str_id[0] == "page" ? "s" : "")
    @div_id = "set-page-div" 
    
    reorder_session(str_id, str_id[2], params[:index])

		respond_to do |format|
      format.js
 		end
	end

	def question_list
		set_options
	end

	def preview
		render layout: false
	end

	def add_row
	end

	def remove_row
	end

	def question_detail
	end

	def question_page
	end

	def reset_session
  	session[current_user.id.to_s].clear
  	redirect_to new_survey_path
	end

  private
  def new_survey
  	@survey = Survey.new
  end

  def set_survey
    @survey = Survey.find(params[:id])
    p @survey
  end

  def upload_image(image)
  	name = current_user.id.to_s + "-" + image.original_filename
    directory = "public/tmp/upload"
    path = File.join(directory, name)
    FileUtils.mkdir_p(directory) unless File.directory?(directory)

		File.unlink(path) if File.file?(path)
    
    File.open(path, "wb") { |f| f.write(image.read) }

    return path
  end

  def survey_params
    params.require(:survey).permit(:name, :description, :period_start, :period_end, :status, :back_page_url, :disclaimer, :user_id)
  end

  def change_format(date)
  	dates = date.split("/")
  	return dates[2] + "-" + dates[0] + "-" + dates[1]
  end

  def set_options
  	@options = Array.new()
		session[current_user.id.to_s]['question'].each do |id, question|
			@options << [question['title'], id] 
		end
  end

  def set_session
		session[current_user.id.to_s] = {} if session[current_user.id.to_s].blank?
		session[current_user.id.to_s]['question'] = {} if session[current_user.id.to_s]['question'].blank?
		session[current_user.id.to_s]['pages'] = {} if session[current_user.id.to_s]['pages'].blank?
  	session[current_user.id.to_s]['logical'] = {} if session[current_user.id.to_s]['logical'].blank?

  	@question_type = [['TextBox', 'textbox'], ['Yes/No', 'yesno'], ['TextBox With Text', 'textbox_text'], ['Paragraph Text', 'paragraph_text'], ['Dropdown', 'dropdown'], ['Radio Button', 'radio_button'], ['CheckBox', 'checkbox'], ['Ranking', 'ranking'], ['Radio Button Grid', 'radio_button_grid'], ['CheckBox Grid', 'checkbox_grid'], ['TextBox Grid', 'textbox_grid'], ['Percentage Scale', 'percentage_scale'], ['Radio Button Scale', 'radio_button_scale'], ['Date', 'date'], ['Time', 'time'], ['Upload', 'upload'], ['Header Text', 'header_text']]
  end

  def reorder_session(str_id, base_id, target_id)
    section = str_id[0] + (str_id[0] == "page" ? "s" : "")
    
    if section == "pages"
    	reorder_page(base_id, target_id)
    	@render_view = "/wizards/pages"
    	@div_id = "set-page-div"
    	@send_params = {}
  	else
  		reorder_question(base_id, target_id, str_id[4])
    	@render_view = "/questions/page_questions"
    	@div_id = "page_questions-"+str_id[4]
    	@send_params = {page: session[current_user.id.to_s]["pages"][str_id[4].to_i], id: str_id[4], exclude_action: false, is_background: false, is_final: false}
  	end
  end

  def reorder_page(base_id, target_id)
  	current_session = session[current_user.id.to_s]["pages"]
  	base_id = current_session[base_id.to_i]["order"]
  	temp_session = {}

  	base_id = base_id.to_i
  	target_id = target_id.to_i

  	if base_id < target_id
  		(base_id..target_id).each do |id|
	  		get_id = base_id + id
	  		get_id = base_id if id == target_id
	  		temp_session[id.to_i] = current_session[get_id.to_i]
	  		temp_session[id.to_i]["order"] = id.to_s
	  		temp_session[id.to_i]["id"] = id.to_s
	  	end
  		reorder_status = true

  	elsif base_id > target_id
  		base_id.downto(target_id) do |id|
  			# get_id = id - target_id
  			get_id = id - 1
  			get_id = base_id if id == target_id
  			temp_session[id.to_i] = current_session[get_id.to_i]
	  		temp_session[id.to_i]["order"] = id.to_s
	  		temp_session[id.to_i]["id"] = id.to_s
  		end
  		reorder_status = true
  	
  	else
  		reorder_status = false

  	end

  	if reorder_status
	  	temp_session.each do |id, pages|
	  		session[current_user.id.to_s]["pages"][id.to_i] = pages
	  	end
  	end
  end

  def reorder_question(base_id, target_id, page_id)
  	current_session = session[current_user.id.to_s]["pages"]
  	question_order = current_session[page_id.to_i]["question_order"]
  	base_id = question_order.select{|index, question_id| index if question_id==base_id }.keys.first
  	temp_session = {}

  	base_id = base_id.to_i
  	target_id = target_id.to_i

  	if base_id < target_id
  		(base_id..target_id).each do |id|
	  		get_id = base_id + id
	  		get_id = base_id if id == target_id
	  		temp_session[id.to_i] = question_order[get_id.to_i]
	  	end
  		reorder_status = true

  	elsif base_id > target_id
  		base_id.downto(target_id) do |id|
  			# get_id = id - target_id
  			get_id = id - 1
  			get_id = base_id if id == target_id
  			temp_session[id.to_i] = question_order[get_id.to_i]
  		end
  		reorder_status = true
  	
  	else
  		reorder_status = false

  	end

  	if reorder_status
	  	temp_session.compact.each do |id, question|
	  		session[current_user.id.to_s]["pages"][page_id.to_i]["question_order"][id.to_i] = question
	  	end
	  	new_array = Array.new
	  	session[current_user.id.to_s]["pages"][page_id.to_i]["question_order"].each do |question|
	  		new_array << question.last
	  	end
	  	session[current_user.id.to_s]["pages"][page_id.to_i]["questions"] = new_array
  	end
  end

end
