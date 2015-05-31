class SearchController < ApplicationController
  include LocationsHelper

  def dish
    dish_search_service = DishSearchService.new(params)
    @dishes = dish_search_service.search
    @search_params = dish_search_service.search_params
    @search_string = dish_search_service.search_string
    @is_geocoded = dish_search_service.geocoded?
    @facets = @dishes.facets
  end
end
