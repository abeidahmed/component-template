class PagesController < ApplicationController
  def home
    @categories = Category.sort_asc
  end
end
