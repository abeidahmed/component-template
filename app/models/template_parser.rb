class TemplateParser
  include PagesHelper

  def initialize(type:, category:, template:)
    @type = type
    @category = category
    @template = template
  end

  attr_reader :type, :category, :template

  def template_path
    Rails.root.join("app", "#{type}", "#{underscorize category.title}", "#{dashed template.title}.html")
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
      FrontMatterParser::Parser.new(:html).call(File.read(template_path)[%r{<body>(.*)</body>}m, 1]).content
    end

    def parse_html
      Nokogiri::HTML(File.read(template_path)).at_css('div.start-below').children.to_html
    end
end