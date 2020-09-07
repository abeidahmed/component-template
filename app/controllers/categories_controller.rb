class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @templates = templates_for(@category)
  end
end
