class TemplateParser
  include PagesHelper

  def initialize(**options)
    @type = options[:type]
    @category = options[:category]
    @template = options[:template]
  end

  def contents
    {
      title: @template.title,
      htmlBody: parse_body,
      displayCode: parse_html,
    }
  end

  private
    def parse_html
      html_code = Nokogiri::HTML(erb_to_html_content)
        .at_css('div.start-below')
        .children
        .to_html
        .html_safe
      HtmlBeautifier.beautify(html_code)
    end

    def parse_body
      erb_to_html_content[%r{<body>(.*)</body>}m, 1]
    end

    def erb_to_html_content
      ERB.new(File.read(template_path)).result(binding)
    end

    def template_path
      Rails.root.join('app', "#{@type}", "#{underscorize @category.title}", "#{dashed @template.title}.html.erb")
    end
end