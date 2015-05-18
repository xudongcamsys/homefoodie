class SearchController < ApplicationController
  def search
    @dishes = Dish.search params[:q], page: params[:page], per_page: params[:per_page] || Kaminari.config.default_per_page
  end
end
