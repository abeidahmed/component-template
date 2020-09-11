class TemplatesController < ApplicationController
  layout "slate"

  def show
    template_filename = params[:id]
    file = Dir["app/components/**/#{template_filename}.html"].first
    redirect_to root_url if file.nil?
    @template = file
  end
end
