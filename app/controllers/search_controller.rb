class SearchController < ApplicationController
  def dish
    dish_search_service = DishSearchService.new(params)
    @dishes = dish_search_service.search
    @search_params = dish_search_service.search_params
    @facets = @dishes.facets
  end

end
