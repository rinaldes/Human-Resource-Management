class UserManagementsController < ApplicationController
  before_action :split_name, only: [:create, :update]


  def index
    conditions_or = []
    ["concat(first_name, ' ', last_name)", 'username', 'email', 'roles.name', 'status'].each{|f|
      conditions_or << "#{f} LIKE '%#{params[:search][:search]}%'"
    } if params[:search].present?
    @users = @current_company.users.where(conditions_or.join(' OR ')).joins(:role).paginate(page: params[:page], per_page: 100)
    @users_count = @current_company.users.where(conditions_or.join(' OR ')).joins(:role).count
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @role = Role.all.map{|x| [x.name, x.id]}
    @user = @current_company.users.build
    respond_to do |format|
      format.js
    end
  end

  def show
    @user = @current_company.users.find_by_id(params[:id])
  end

  def create
  	@user = @current_company.users.build(user_params.merge(status: "Active"))
  	respond_to do |format|
      format.js
    end
  end

  def edit
    @role = Role.all.map{|x| [x.name, x.id]}
    @user = @current_company.users.find_by_id(params[:id])
    respond_to do |format|
        format.js
      end
  end

  def update
    @user = @current_company.users.find_by_id(params[:user][:id])
    @user.update(user_params)
    respond_to do |format|
        format.js
      end
  end

  def destroy
    params[:check].each do |delete|
      User.find_by_id(delete).destroy
    end
    respond_to do |format|
      format.js
    end
  end
  private
	  def split_name
	  	name = params[:user][:first_name].split(' ')
	  	params[:user][:first_name] = name[0]
	  	name.delete(name[0])
	  	params[:user][:last_name] = name.join(' ')
	  	params[:user][:password] = Time.now.strftime("%Y%m%d%H%S")
	  	params[:user][:password_generate] = Time.now.strftime("%Y%m%d%H%S")
	  end

	  def user_params
	  	params.require(:user).permit(:first_name, :last_name, :username, :password, :role_id, :password_generate, :email, :status)
	  end
end
