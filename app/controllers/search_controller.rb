class SearchController < ApplicationController

  def dish
    dish_searcher = DishSearcher.new(params)
    @dishes = dish_searcher.search
    @search_params = dish_searcher.search_params
    @search_string = dish_searcher.search_string
    @is_geocoded = dish_searcher.geocoded?
    @facets = @dishes.facets
  end
end
