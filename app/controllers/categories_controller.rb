class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @type = params[:type]
    @templates = @category.components.present? ? @category.components : @category.pages
  end
end
