class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @templates = Dir["app/templates/#{underscorize(@category.title)}/*.liquid"]
  end
end
