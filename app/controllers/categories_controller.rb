class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @templates ||= templates_for(@category).sort_by { |name| File.basename(name) }
  end
end
