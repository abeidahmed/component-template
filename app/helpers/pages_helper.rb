module PagesHelper
  def parse(file)
    liquid = File.read(file)
    FrontMatterParser::Parser.new(:liquid).call(liquid)
  end

  def underscorize(string)
    string.split(' ').map { |el| el.downcase }.join('_')
  end

  def embed_svg(filename, options = {})
    svg_path = Rails.application.assets
    file = svg_path.find_asset("svg/#{filename}.svg").source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end
end
