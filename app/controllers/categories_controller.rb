class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @templates = templates_for(@category)
  end
end
