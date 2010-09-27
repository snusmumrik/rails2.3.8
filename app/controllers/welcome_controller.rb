class WelcomeController < ApplicationController
  def index
    # if /[^0-9]/ =~ params[:id]
    #   @maker = Maker.first(:conditions => ["name = ?", params[:id]])
    # else 
    #   @maker = Maker.find(params[:id])
    # end

    # @posts = Posts.paginate(:all, 
    #                         :order => "updated_at DESC", 
    #                         :conditions => 'posts.deleted_at IS NULL',
    #                         :per_page => 10, 
    #                         :page => params[:page])

    begin
      brand_category = 0
      brand_name = 'adidas'
      @amazon_recommendations = AmazonAwsSearch.item_search(brand_category, {'Brand' => brand_name})
      @height_ex_array = []
      @width_ex_array = []
      @amazon_recommendations.each do |r|
        if r.medium_image.height.to_i > 130
          @height_ex_array << r.medium_image.url
        elsif r.medium_image.width.to_i > 130
          @width_ex_array << r.medium_image.url
        end
      end
    rescue => e
      @amazon_error = e
    end

    begin
      brand_category = 0
      brand_name = 'プラダ'
      @rakuten_recommendations = RakutenSearch.item_search(brand_category, brand_name)
    rescue  => e
      @rakuten_error = e
    end

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
