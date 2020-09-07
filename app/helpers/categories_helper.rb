module CategoriesHelper
  def templates_for(category)
    Dir["app/templates/#{underscorize(category.title)}/*.liquid"]
  end
end
