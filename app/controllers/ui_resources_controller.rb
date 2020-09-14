class UiResourcesController < ApplicationController
  layout 'slate'

  def index
    @components = YAML::load_file(file_path('components'))
    @pages = YAML::load_file(file_path('pages'))
  end

  def show
    type, template_name = params[:type], params[:id]

    found_template = find_template(type)
    @template = found_template.render(template_name) unless found_template.nil?
  end

  private
    def file_path(file_name)
      Rails.root.join('db', "#{file_name}.yml")
    end

    class ComponentTemplate
      def match?(type)
        type == 'components'
      end

      def render(component_template)
        Component.find_by(title: component_template.underscore.humanize)
      end
    end

    class PageTemplate
      def match?(type)
        type == 'pages'
      end

      def render(page_template)
        Page.find_by(title: page_template.underscore.humanize)
      end
    end

    def template_list
      component = ComponentTemplate.new
      page = PageTemplate.new
      [component, page]
    end

    def find_template(template_type)
      template_list.find { |template| template.match?(template_type) }
    end
end
