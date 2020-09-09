module PagesHelper
  def page_title(title)
    base_title = 'Tailwind component'
    if title.empty?
      base_title
    else
      "#{title} | #{base_title}"
    end
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
