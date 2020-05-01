class VisionsController < ApplicationController
  def index
    @company = current_user.company
    @vision = @company.vision
  end

  def show
    @company = current_user.company
    @visions = @company.visions
  end

  def setup
    company_id = current_user.company_id
    visi = Vision.find_by_company_id(company_id)
    if visi.present?
      visi.update(content_ind: params[:content][:id], content_eng: params[:content][:en])
    else
      Vision.create(content_ind: params[:content][:id], content_eng: params[:content][:en], company_id: company_id)
    end
    @current_company.users.update_all(:flag_company_dashboard => true)
    FlagCompany.where(:user_id => @current_company.users).update_all(:vision => true)
    index
    respond_to {|format|
      format.js
    }
  end

  def visi_misi
  end
end