class Admin::PasswordsController < ApplicationController
	layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!
  before_filter :admin_authenticate

	def create
	  admin = Admin.find_by_email(params[:email])
	  admin.send_password_reset if admin
	  redirect_to admin_root_url, :notice => "Email sent with password reset instructions."
	end

	def edit
	  @admin = Admin.find_by_password_reset_token!(params[:id])
	end

	def update
	  @admin = Admin.find_by_password_reset_token!(params[:id])
	  if @admin.password_reset_sent_at < 2.hours.ago
	    redirect_to new_admin_password_path, :alert => "Password reset has expired."
	  elsif @admin.update_attributes(admin_params)
	    redirect_to admin_root_url, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
	end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:password, :password_confirmation)
    end
end
