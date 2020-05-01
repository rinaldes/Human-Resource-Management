class CulturesController < ApplicationController
  def index
    @company = current_user.company
    @culture = @company.culture
    # @en_text = @company.culture('en')
    # @id_text = @company.culture('id')
  end

  def show
    @company = current_user.company
    @cultures = @company.cultures
  end

  def setup
   company_id = current_user.company_id
   cult = Culture.find_by_company_id(company_id)
   if cult.present?
     cult.update(content_ind: params[:content][:id], content_eng: params[:content][:en])
   else
     Culture.create(content_ind: params[:content][:id], content_eng: params[:content][:en], company_id: company_id)
   end
    @company = current_user.company
    @culture = @company.culture
    @current_company.users.update_all(:flag_company_dashboard => true)
    FlagCompany.where(:user_id => @current_company.users).update_all(:culture => true)
    respond_to {|format|
     format.js
   }
 end
end
