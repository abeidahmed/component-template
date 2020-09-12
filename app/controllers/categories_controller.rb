class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @templates = @category.fetch_components_directory.sort_by { |name| File.basename(name) }
  end
end
