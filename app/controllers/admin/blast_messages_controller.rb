class Admin::BlastMessagesController < ApplicationController
	layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!
  before_filter :admin_authentication
  autocomplete :company, :com_email

  def index
  	@blast_message = BlastMessage.new
  end

  def create
  	blast_message_params = {}
  	blast_message_params[:message] = params[:blast_message][:message]
  	blast_message_params[:email] = current_admin.email
  	blast_message_params[:name] = current_admin.first_name.to_s + " " + current_admin.last_name.to_s
  	blast_message_params[:sender_type] = "admin"
  	blast_message_params[:blastmessage_type] = 3

  	@blast_message = BlastMessage.new(blast_message_params)
    
    respond_to do |format|
      if @blast_message.save
      	unless params[:blast_message][:send_type] == "all"
		  		receiver_emails = params[:blast_message][:sender_id].first.split(",")
		  		receiver_emails.each do |email|
		  			if email.present?
			  			company = Company.find_by_com_email(email)
			  			BlastMessageDetail.create!(company_id: company.id, blast_message_id: @blast_message.id) if company.present?
			  		end
		  		end
		  	else
		  		Company.all.each do |company|
			  		BlastMessageDetail.create!(company_id: company.id, blast_message_id: @blast_message.id)
		  		end
		  	end
        format.html { redirect_to admin_blast_messages_path, notice: 'Blas message was successfully created.' }
        format.json { render :show, status: :created, location: @blast_message }
      else
        format.html { render :index }
        format.json { render json: @blast_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def autocomplete_company_email
	  render json: Company.where("com_email like '%#{params[:term]}%'").map { |company| {value: company.com_email.to_s, text: company.com_email.to_s} }
  end
end