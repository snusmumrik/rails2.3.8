# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem

  layout 'welcome'

  # render new.rhtml
  def new
    @email = session[:email]
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = t('notice.session.logged_in_successfully')
    else
      note_failed_signin
      @email       = params[:email]
      @remember_me = params[:remember_me]
      redirect_back_or_default(:action => :new)
      # render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = t('notice.session.you_have_been_logged_out')
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = t('error.session.email_or_password_may_be_incorrect')
    logger.warn "Failed login for '#{params[:email]}' from #{request.remote_ip} at #{Time.now.localtime}"
  end
end
