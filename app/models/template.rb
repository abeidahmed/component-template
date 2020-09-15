class Template
  class ComponentFinder
    def match?(type)
      type == 'components'
    end

    def render(template_filename)
      Component.find_by(title: template_filename.underscore.humanize)
    end
  end

  class PageFinder
    def match?(type)
      type == 'pages'
    end

    def render(template_filename)
      Page.find_by(title: template_filename.underscore.humanize)
    end
  end
end