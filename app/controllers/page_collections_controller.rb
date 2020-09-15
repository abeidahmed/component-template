class PageCollectionsController < ApplicationController
  def index
    @page_collections = PageCollection.all
  end
end
