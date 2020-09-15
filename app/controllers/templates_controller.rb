class TemplatesController < ApplicationController
  layout 'slate'

  def show
    template_filename = params[:id]
    @type = params[:type]
    @template = template_type.render(template_filename) unless template_type.nil?
  end

  private
    def template_list
      component = Template::ComponentFinder.new
      page = Template::PageFinder.new
      [component, page]
    end

    def template_type
      template_list.find { |type| type.match?(@type) }
    end
end
