class TemplateParser
  def initialize(file)
    @file = file
  end

  def get_title
    parse_frontmatter["title"]
  end

  def parse_body
    html_content = File.read(@file)
    parser.call(html_content[%r{<body>(.*)</body>}m, 1])
  end

  def parse_html(target)
    nokogiri_object = Nokogiri::HTML(File.read(@file))
    nokogiri_object.at_css(target).children.to_html
  end

  private
    def parser
      FrontMatterParser::Parser.new(:html)
    end

    def parse_frontmatter
      parser.call(File.read(@file))
    end
end