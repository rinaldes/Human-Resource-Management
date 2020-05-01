class BlastMailer < ActionMailer::Base
  # default from: "taufik_h@pratesis.com"

  def blast_email(blast)
  	@message = blast.blast_message
  	# mail(to: blast.employee.corporate_email , from: User.find(@message.sender_id).employee.corporate_email , subject: 'Blast Message')
  	mail(to: blast.employee.corporate_email , subject: 'Blast Message')
  end

  def send_email(current_user, blast_message, employee, subject)
	mail_corporate = current_user.employee.corporate_email
	options = {
        :address              => 'mail.pratesis.com',
        :domain               => 'pratesis.com',
        :port                 => 465,
        :user_name            => mail_corporate.email,
        :password             => mail_corporate.password,
        :authentication       => 'login',
        :ssl                  => true,
    	:openssl_verify_mode  => 'none'
    }
    Mail.defaults do
        delivery_method :smtp, options
    end

    mail = Mail.new do
        from      mail_corporate.email
        to        employee.corporate_email.email
        subject   subject
        html_part do
            content_type 'text/html; charset=UTF-8'
            body blast_message.message
        end
    end
    mail.deliver!
  end


end
