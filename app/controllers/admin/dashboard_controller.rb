class Admin::DashboardController < ApplicationController
	layout 'admin/layouts/application'
  skip_before_filter :authenticate_user!
  before_filter :admin_authentication, only: [:index]

  def index
  	@companies = Company.all
  end
end
