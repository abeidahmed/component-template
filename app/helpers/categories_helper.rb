module CategoriesHelper
  def templates_for(category)
    Dir["app/components/#{underscorize(category.title)}/*.html"]
  end
end
