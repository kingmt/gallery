class UsersController < ApplicationController
  
  before_filter :admin_only

  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(users_url) 
    else
       render :action => "edit" 
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    #logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      redirect_to(users_url) 
      flash[:notice] = "New user successfully created."
    else
      #flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User successfully removed."
    redirect_to(users_url)
  end
  
  private
  def admin_only
    unless logged_in? && current_user.is_admin?
      if logged_in?
        # not an admin
        flash[:notice] = 'Access Denied'
      else
        flash[:notice] = 'Please log in.'
      end
      redirect_to '/'
    end
  end
end
