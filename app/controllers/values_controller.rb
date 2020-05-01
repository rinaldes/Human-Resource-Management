class ValuesController < ApplicationController
  def index
    @company = current_user.company
    @value = @company.value
    #@en_text = @company.value('en')
    #@id_text = @company.value('id')
  end

  def show
    @company = current_user.company
    @values = @company.values
  end


  def setup
    company_id = current_user.company_id
    val = Value.find_by_company_id(company_id)
    if val.present?
      val.update(content_ind: params[:content][:id], content_eng: params[:content][:en])
    else
      Value.create(content_ind: params[:content][:id], content_eng: params[:content][:en], company_id: company_id)
    end
    @current_company.users.update_all(:flag_company_dashboard => true)
    FlagCompany.where(:user_id => @current_company.users).update_all(:value_company => true)
    index
    respond_to {|format|
      format.js
    }
  end
end
