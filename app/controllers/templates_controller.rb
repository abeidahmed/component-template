class TemplatesController < ApplicationController
  layout "slate"

  def show
    template_filename = params[:id]
    @component = Component.find_by(title: underscorize(template_filename).humanize)
    file = Dir["app/components/**/#{template_filename}.html"].first
    redirect_to root_url if file.nil?
    @template = file
  end
end
