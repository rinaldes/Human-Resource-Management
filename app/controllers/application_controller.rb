class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_admin
  before_action :current_company
  before_filter :set_locale
  before_filter :need_header_and_sidebar
  # before_action :check_role

  def need_header_and_sidebar
    @need_header_and_sidebar = !%w(misions_show cultures_show code_of_conducts_show values_show visions_show).include?("#{params[:controller]}_#{params[:action]}")
    if current_user.present?
      @features = current_user.role.features.where("name NOT IN ('employee_surveys', 'employee_histories', 'families', 'personal_datas', 'salaries', 'employee_working_datas','position_details', 'misions', 'cultures', 'code_of_conducts', 'values', 'attendance_settings', 'holidays', 'organizations', 'shifts', 'schedules', 'test_results', 'interview_results', 'employee_resigns', 'performances',  'photo_activities', 'components', 'internal_work_experiences', 'external_work_experiences', 'categories', 'devisions', 'certifications', 'contracts', 'skills', 'violation_details', 'history_of_organizations', 'education_details', 'language_skills', 'training_histories')").joins(:feature_name)
    end
  end

  def authenticate_admin
    unless current_user.role == "admin"
      redirect_to root_path, :notice => "Authenticated admin needed here!"
    end
  end


  def set_locale
    session[:language] = 'en' unless session[:language]
    I18n.locale = session[:language]
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def admin_authentication
    unless current_admin
      redirect_to admin_root_path, :notice => "Authenticated admin needed here!"
    end
  end

  def admin_authenticate
    if current_admin
      redirect_to admin_dashboard_path, :notice => "Already logged in as #{current_admin.email}!"
    end
  end

  

  private
  def current_admin
    @current_admin ||= Admin.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    # @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end

  def check_role
    if params[:controller] != 'dashboards'
      controller = current_user.role.features.joins(:feature_name).where('feature_names.name = ?', params[:controller]).first
      if controller.present?
        if controller.feature_group.name == 'read'
          if params[:action] != 'show' and params[:action] != 'index'
            redirect_to :controller => params[:controller], :action => 'index'
          end
        end
      else
        redirect_to :controller => 'dashboards', :action => 'index'
      end
    end
  end
end
