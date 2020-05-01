class CodeOfConductsController < ApplicationController
  def index
    @company = current_user.company
    @code_of_conduct = @company.code_of_conduct
    # @en_text = @company.code_of_conduct('en')
    # @id_text = @company.code_of_conduct('id')
  end

  def show
    @company = current_user.company
    @code_of_conducts = @company.code_of_conducts
  end

  def setup
   company_id = current_user.company_id
   coc = CodeOfConduct.find_by_company_id(company_id)
   if coc.present?
     coc.update(content_ind: params[:content][:id], content_eng: params[:content][:en])
   else
     CodeOfConduct.create(content_ind: params[:content][:id], content_eng: params[:content][:en], company_id: company_id)
   end
    @current_company.users.update_all(:flag_company_dashboard => true)
    FlagCompany.where(:user_id => @current_company.users).update_all(:code_of_conduct => true)
    index
    respond_to {|format|
     format.js
   }
 end
end
