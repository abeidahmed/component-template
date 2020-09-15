class UiResourcesController < ApplicationController
  layout 'slate'

  def index
    @components = YAML::load_file(file_path('components'))
    @pages = YAML::load_file(file_path('pages'))
  end

  def show
    @type, template_name = params[:type], params[:id]
    @template = template_type.render(template_name) unless template_type.nil?
  end

  private
    def file_path(file_name)
      Rails.root.join('db', "#{file_name}.yml")
    end

    def template_list
      component = Template::ComponentFinder.new
      page = Template::PageFinder.new
      [component, page]
    end

    def template_type
      template_list.find { |type| type.match?(@type) }
    end
end
