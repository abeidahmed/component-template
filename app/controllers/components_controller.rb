class ComponentsController < ApplicationController
  layout "slate"

  def show
    template_filename = params[:id]
    @component = Component.find_by(title: underscorize(template_filename).humanize)
  end
end
