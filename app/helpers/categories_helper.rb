module CategoriesHelper
  def templates_for(category)
    Dir["app/templates/#{underscorize(category.title)}/*.html"]
  end
end
