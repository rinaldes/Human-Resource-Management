class MisionsController < ApplicationController
  def index
    @company = current_user.company
    @mision = @company.mision
    # @en_text = @company.mision('en')
    # @id_text = @company.mision('id')
  end

  def show
    @company = current_user.company
    @misions = @company.misions
  end

  def setup
   company_id = current_user.company_id
   misi = Mision.find_by_company_id(company_id)
   if misi.present?
     misi.update(content_ind: params[:content][:id], content_eng: params[:content][:en])
   else
     Mision.create(content_ind: params[:content][:id], content_eng: params[:content][:en], company_id: company_id)
   end
   @current_company.users.update_all(:flag_company_dashboard => true)
   FlagCompany.where(:user_id => @current_company.users).update_all(:mision => true)
    index
    respond_to {|format|
     format.js
   }
 end
end
