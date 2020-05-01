class BlastMessagesController < ApplicationController
before_action :get_employees
before_action :get_organizations
autocomplete :employee, :name
autocomplete :organization, :name
  def index
	@blast_messages = BlastMessage.all
  @blast_message = BlastMessage.new
  end

  def show
    @blast_message = BlastMessage.find(params[:id])
  end
  
  def new
	@blast_message = BlastMessage.new

  end

  def create
    blast_message_params[:email] = current_company.com_email
    blast_message_params[:name] = current_company.owner_name
    @blast_message = BlastMessage.new(blast_message_params.merge(sender_type: "Company", sender_id: current_user.id))
    respond_to do |format|
      if @blast_message.save
        subject = 'Blast Message -' + (params[:blast_message][:blastmessage_type] == 1 ? 'Message' : 'Motivate')
        if params[:blast_message][:send_type] == "all"
          # Employee.all.each do |employee|
          @current_company.employees.each do |employee|
            BlastMessageDetail.create!(employee_id: employee.id, blast_message_id: @blast_message.id)
            BlastMailer.send_email(current_user, @blast_message, employee, subject)
          end
        elsif params[:blast_message][:send_type] == "emp"
          receiver_emails = params[:blast_message][:sender_id].first.split(",")
          receiver_emails.each do |name|
            if name.present?
              employee = Employee.find_by_name(name)
              BlastMessageDetail.create!(employee_id: employee.id, blast_message_id: @blast_message.id) if employee.present?
              BlastMailer.send_email(current_user, @blast_message, employee, subject)
            end
          end
        elsif params[:blast_message][:send_type] == "dvi"
          receiver_emails = params[:blast_message][:sender_id][1].split(",")
          receiver_emails.each do |name|
            if name.present?
              organization = Organization.find_by_name(name)
              BlastMessageDetail.create!(organization_id: organization.id, blast_message_id: @blast_message.id) if organization.present?
              organization.employees.each do |employee|
                BlastMailer.send_email(current_user, @blast_message, employee, subject)
              end
            end
          end
        elsif params[:blast_message][:send_type] == "com"
=begin
          receiver_emails = params[:blast_message][:sender_id].first.split(",")
          receiver_emails.each do |email|
            if email.present?
              company = Company.find_by_email(email)
              BlastMessageDetail.create!(organization_id: company.id, blast_message_id: @blast_message.id) if company.present?
            end
          end
algoritma lama, hanya company yg disebutkan emailnya yg kekirim
=end
          BlastMessageDetail.create!(company_id: current_user.company_id, blast_message_id: @blast_message.id)#user company create blast message tipe company, maka smua user pd company tsb dpt melihat msg tsb
          @current_company.employees.each do |employee|
            BlastMailer.send_email(current_user, @blast_message, employee, subject)
          end
        end
        format.html { redirect_to blast_messages_path, notice: 'Blas message was successfully created.' }
        format.json { render :show, status: :created, location: @blast_message }
      else
        @blast_message_errors = @blast_message.errors.full_messages.join('<div class="clearFix"/>')
        format.html { render :index }
        format.json { render json: @blast_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
	@blast_message = BlastMessage.find(params[:id])
  end
  def autocomplete_employee_name
    render json: Employee.where("name like '%#{params[:term]}%'").map { |employee| {value: employee.name.to_s, text: employee.name.to_s} }
  end
  def autocomplete_organization_name
    render json: Organization.where("name like '%#{params[:term]}%'").map { |organization| {value: organization.name.to_s, text: organization.name.to_s} }
  end
  private
  def get_employees
    @employees = Employee.all.map { |e| [e.name, e.id] }
    
  end
  private
  def get_organizations
    @organizations = Organization.all.map { |e| [e.name, e.id] }
    
  end
  def blast_message_params
     params.require(:blast_message).permit(:email, :message, :sender_id, :blastmessage_type, :sender_type, :image, :background_color)
    #params.require(:blast_message).permit(:email, :message, :sender_id, :blastmessage_type, :sender_type, :image)
  end
end
