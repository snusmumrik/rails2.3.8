class WelcomeController < ApplicationController
  def index
    # @posts = Posts.paginate(:all, 
    #                         :order => "updated_at DESC", 
    #                         :conditions => 'models.deleted_at IS NULL',
    #                         :per_page => 10, 
    #                         :page => params[:page])
  end

end
