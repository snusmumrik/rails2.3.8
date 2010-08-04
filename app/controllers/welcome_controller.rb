class WelcomeController < ApplicationController
  def index
    # @posts = Posts.paginate(:all, 
    #                         :order => "updated_at DESC", 
    #                         :conditions => 'posts.deleted_at IS NULL',
    #                         :per_page => 10, 
    #                         :page => params[:page])
  end

  # # GET /bikes/search/keyword
  # # GET /bikes/search/keyword.xml
  # def search
  #   if params[:keyword] != ""
  #     @bikes = Bike.paginate(:all,
  #                            :joins => 'LEFT JOIN models ON bikes.model_id = models.id',
  #                            # :order => 'updated_at DESC', 
  #                            :conditions => ["models.name like ? and bikes.deleted_at IS NULL", '%' + params[:keyword] + '%'],
  #                            :per_page => 10, 
  #                            :page => params[:page])
  #     @keyword = params[:keyword]
  #   else
  #     redirect_to root_url
  #     return true
  #   end
  #   render :action => "index"
  # end
end
