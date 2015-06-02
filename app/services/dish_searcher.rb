class DishSearcher
  attr_accessor :search_params 

  DEFAULT_SORTING_KEY = 'rating_desc'

  def initialize(search_params = {})
    @search_params = parse_params search_params
  end

  def search
    @dishes = Dish.search search_params[:q], 
      page: search_params[:page], 
      per_page: search_params[:per_page],
      order: order,
      where: where,
      facets: [:food_preference, :food_type, :cuisine]
  end

  # serialized search query string
  def search_string
    [:q, :sort, :per_page, :lat, :lng, :within_dist].map { |key| "#{key.to_s}=#{@search_params[key]}" }.join("&")
  end

  def geocoded?
    @search_params[:lat] && @search_params[:lng]
  end

  def search_by_dist?
    geocoded? && @search_params[:within_dist]
  end

  private

  def parse_params(params = {})
    search_params = {}

    # search keyword
    search_params[:q] = params[:q].blank? ? '*' : params[:q]

    # sort 
    search_params[:sort] = params[:sort].blank? ? DEFAULT_SORTING_KEY : params[:sort]

    # pagination
    search_params[:page] = params[:page]
    search_params[:per_page] = params[:per_page] || Kaminari.config.default_per_page

    # within_distance
    search_params[:within_dist] = params[:within_dist].try(:to_f) if !params[:within_dist].blank?
    
    # latitude and longitude
    search_params[:lat] = params[:lat].try(:to_f) if !params[:lat].blank?
    search_params[:lng] = params[:lng].try(:to_f) if !params[:lng].blank?

    # facet params
    search_params[:facets] = params.permit(:food_preference, :food_type, :cuisine)

    search_params
  end

  def order
    if @search_params[:sort] == DEFAULT_SORTING_KEY
      {rating: { order: "desc", ignore_unmapped: true} }
    elsif geocoded?
      # distance_desc
      {
        _geo_distance: {
          location: "#{@search_params[:lat]},#{@search_params[:lng]}",
          order: "asc"
        }
      }
    end
  end

  def where
    where_cond = {}
    if search_by_dist?
      where_cond = {location: {near: [@search_params[:lat], @search_params[:lng]], within: "#{@search_params[:within_dist]}mi"}}
    end

    where_cond.merge!(@search_params[:facets])
  end
end