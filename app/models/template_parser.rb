class TemplateParser
  include PagesHelper

  def initialize(type:, category:, template:)
    @type = type
    @category = category
    @template = template
  end

  attr_reader :type, :category, :template

  def template_path
    Rails.root.join("app", "#{type}", "#{underscorize category.title}", "#{dashed template.title}.html.erb")
  end

  def contents
    {
      title: template.title,
      htmlBody: parse_body,
      displayCode: parse_html,
    }
  end

  private
    def parse_body
      FrontMatterParser::Parser.new(:html).call(get_after_body).content
    end

    def parse_html
      Nokogiri::HTML(erb_to_html(template_path), &:noblanks).at_css('div.start-below').children.to_xhtml(indent: 2)
    end

    def get_after_body
      erb_to_html(template_path)[%r{<body>(.*)</body>}m, 1]
    end

    def erb_to_html(file_path)
      ERB.new(File.read(file_path)).result(binding)
    end
end