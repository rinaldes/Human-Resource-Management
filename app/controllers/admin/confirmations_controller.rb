class Admin::ConfirmationsController < ApplicationController
	layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!

  def index
  	company = Company.find_by_confirm_token(params[:id])
    if company
      company.email_activate
      flash_notice = "Your company email has been confirmed. Please sign in to continue."
    else
      flash_notice = "Sorry. Company does not exist!"
    end
  	redirect_to new_session_path(User), :notice => flash_notice
  end
end
