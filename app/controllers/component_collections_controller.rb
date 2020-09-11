class ComponentCollectionsController < ApplicationController
  def index
    @component_collections = ComponentCollection.all
  end
end
