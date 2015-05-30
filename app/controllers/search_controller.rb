class SearchController < ApplicationController
  def dish
    search_param = params[:q].blank? ? '*' : params[:q]

    @sort_key = params[:sort].blank? ? 'rating_desc' : params[:sort]
    if @sort_key == 'rating_desc'
      order = {rating: :desc}
    else
      order = {
        _geo_distance: {
          location: "40,-70",
          order: "desc"
        }
      }
    end

    @dishes = Dish.search search_param, 
      page: params[:page], per_page: params[:per_page] || Kaminari.config.default_per_page,
      order: order,
      where: params.permit(:food_preference, :food_type, :cuisine),
      facets: [:food_preference, :food_type, :cuisine],
      fields: ["location"]

    @facets = @dishes.facets
  end
end
