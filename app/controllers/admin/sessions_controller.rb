class Admin::SessionsController < ApplicationController
	layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!
  before_filter :admin_authentication, only: [:destroy]
  before_filter :admin_authenticate, except: [:destroy]

	def new
		session[:text] = SecureRandom.hex(10)[0..6]
    image = MiniMagick::Image.open("#{Rails.root.to_s}/public/images/captcha.jpeg")
    image.combine_options do |c|
      c.gravity 'Center'
      c.pointsize '22'
      c.draw "text 0,0 '#{session[:text]}'"
      c.fill 'white'
    end
    image.write("#{Rails.root.to_s}/public/images/captcha/#{session[:text]}.jpeg")
	end

	def create
	  admin = Admin.authenticate(params[:username], params[:password])
	  
	  if params[:captcha] == session[:text] && admin
	    if params[:remember_me]
	      cookies.permanent[:auth_token] = admin.auth_token
	    else
	      cookies[:auth_token] = admin.auth_token
	    end
	    redirect_to admin_dashboard_url, :notice => "Logged in!"
    else
    	if admin
	    	flash_message = "Your captcha is incorect"
    	else
	    	flash_message = "Invalid username or password"
    	end
    	flash.now.alert = flash_message
	    render "new"
    end
	end

	def destroy
	  cookies.delete(:auth_token)
  	redirect_to admin_root_url, :notice => "Logged out!"
	end
end
