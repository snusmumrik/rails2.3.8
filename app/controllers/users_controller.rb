class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem

  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]

  # login required except signup
  # before_filter :login_required , :except => [:new]
  before_filter :login_required , :only => [:edit, :update, :destroy]

  layout 'welcome'

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    unless owner_authorized?(@user.id)
      flash[:error] = "You don't have access to this user."
      # redirect_to(user_path(@user))
      return
    end
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/signin')
      flash[:notice] = t('notice.user.thanks_for_signing_up')
    else
      flash[:error]  = t('error.user.we_couldn\'t_set_up_that_account')
      render :action => 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t('notice.user.user_was_successfully_updated')
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      session[:email] = user.email
      flash[:notice] = t('notice.user.signup_complete')
      redirect_to('/signin')
    when params[:activation_code].blank?
      flash[:error] = t('error.user.the_activation_code_was_missing')
      redirect_back_or_default('/signin')
    else 
      flash[:error]  = t('error.user.we_couldn\'t_find_a_user_with_that_activation_code')
      redirect_back_or_default('/signin')
    end
  end

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:notice] = "Reset code sent to #{user.email}"
      else
        flash[:notice] = "#{params[:user][:email]} does not exist in system"
      end
      redirect_back_or_default('/')
    end
  end
  
  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        self.current_user = @user
        @user.delete_reset_code
        flash[:notice] = "Password reset successfully for #{@user.email}"
        redirect_back_or_default('/')
      else
        render :action => :reset
      end
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
