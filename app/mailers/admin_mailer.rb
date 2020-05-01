class AdminMailer < ActionMailer::Base
  default from: "taufik_h@pratesis.com"
  # default from: "hrmpinus@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.password_reset.subject
  #
  def password_reset(admin)
    @admin = admin
    mail :to => admin.email, :subject => "Password Reset"
  end

  def registration_confirmation(company)
    @company = company
    mail(to: company.com_email, :subject => "Registration Confirmation")
  end

  def testing(mail)
    mail(to: mail, :subject => "Registration Confirmation")
  end

end
