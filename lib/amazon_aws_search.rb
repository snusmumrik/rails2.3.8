include Amazon::AWS
include Amazon::AWS::Search

class AmazonAwsSearch
  @@amazon_category = {0 => 'Apparel', 
                       1 => 'Beauty', 
                       2 => 'Books'
                       }

  def self.item_search(category, parameters)
    is = ItemSearch.new( "#{@@amazon_category[category]}", parameters )
    is.response_group = ResponseGroup.new( :Medium )
    req = Request.new
    req.locale = 'jp'

    resp = req.search( is )
    items = resp.item_search_response[0].items[0].item
  end

  def self.keyword_search(search_word, category = 'Blended')
    is = ItemSearch.new( category, { 'Keywords' => search_word } )
    is.response_group = ResponseGroup.new( :Medium )
    req = Request.new
    req.locale = 'jp'

    resp = req.search( is )
    items = resp.item_search_response[0].items[0].item
  end
end
