class Admin::UsersController < Admin::ApplicationController
  before_action :verify_logged_in
  
  def new
    @page_title = "Add User"
    @users = User.new
  end

  def create
    @users = User.new(user_params)
    if @users.save
      flash[:notice] = "User Created"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])

    if @users.update(user_params)
      flash[:notice] = "User Updated"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy

    flash[:notice] = "User Removed"
    redirect_to admin_users_path
  end

  def index
    @users = User.all
    if params[:search]
      # select searched post and sorted descend
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    else
      # select all post and sorted descend
      @users = User.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
