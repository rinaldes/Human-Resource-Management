class CategoriesController < ApplicationController
  def index
    @categories = Category.joins(:user).where("users.company_id=#{@current_user.company_id}").paginate(page: params[:page], per_page: 100)
    respond_to do |format|
      format.html
      format.xls
      if(params[:a] == "a")
        format.csv { send_data @categories.to_csv2 }
      else
        format.csv { send_data @categories.to_csv }
      end
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.js
    end
  end

  def import
    Category.import(params[:file])
    redirect_to categories_path, notice: "Category imported."
  end

  def create
    @category = Category.new(category_params.merge(created_by: @current_user.id))
    respond_to do |format|
      format.js
    end
  end

  def destroy
    params[:check].each do |delete|
      Category.find_by_id(delete).destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @category = Category.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @category = Category.find_by_id(params[:category][:id])
    @category.update_attributes(category_params.merge(updated_by: @current_user.id))
    respond_to do |format|
      format.js
    end
  end

  private
    def category_params
      params.require(:category).permit(:id, :name, :category_group)
    end
end
