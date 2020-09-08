module PagesHelper
  def read_file(file)
    File.read(file)
  end

  def parse(file)
    FrontMatterParser::Parser.new(:html).call(read_file(file))
  end

  def parse_html(file)
    nokogiri_object = Nokogiri::HTML(read_file(file))
    nokogiri_object.css("div.start-below").children.to_html
  end

  def underscorize(string)
    regex = /(\W|\_)/
    chars = string.gsub(regex, ' ')
    chars.split(' ').map { |el| el.downcase }.join('_')
  end

  def embed_svg(filename, **options)
    file_path = Rails.root.join('app', 'assets', 'images', 'svg', filename)
    return unless File.exists?(file_path)
    file = File.read(file_path)
    doc = Nokogiri::HTML::DocumentFragment.parse(file)
    svg = doc.at_css('svg')
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
end
