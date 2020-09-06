module PagesHelper
  def parse(file)
    liquid = File.read(file)
    FrontMatterParser::Parser.new(:liquid).call(liquid)
  end

  def underscorize(string)
    string.split(' ').map { |el| el.downcase }.join('_')
  end

  def embed_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
end
