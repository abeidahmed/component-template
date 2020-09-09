class TemplatesController < ApplicationController
  layout "slate"

  def show
    template_filename = params[:id]
    @template = Dir["app/templates/**/#{template_filename}.html"].first
  end
end
