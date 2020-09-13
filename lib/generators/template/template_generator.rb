class TemplateGenerator < Rails::Generators::Base
  include ApplicationHelper

  source_root File.expand_path('templates', __dir__)
  argument :category_title, type: :string
  argument :template_title, type: :string

  class_option :type, type: :string

  def generate_template
    @type = options['type']
    if @type == 'component'
      create_component_template
      copy_component_template
      generate_components_yaml_file
    elsif @type == 'page'
      create_page_template
      copy_page_template
      generate_pages_yaml_file
    else
      puts "You did not pass any flags. [--type=component || --type=page]"
    end
  end

  private
    def copy_component_template
      copy_file "template_boilerplate.html.erb",
        "app/components/#{underscorize(category_title)}/#{template_title.dasherize}.html.erb"
    end

    def create_component_template
      category = get_category(category_title)
      Component.create!(title: template_title.humanize, category_id: category.id)
    end

    def generate_components_yaml_file
      YamlWriter.new(
        type: get_categorizable_title(category_title),
        category: category_title,
        template_name: template_title,
        file_name: 'components'
      ).write!
    end

    def copy_page_template
      copy_file "template_boilerplate.html.erb",
        "app/pages/#{underscorize(category_title)}/#{template_title.dasherize}.html.erb"
    end

    def create_page_template
      category = get_category(category_title)
      Page.create!(title: template_title.humanize, category_id: category.id)
    end

    def generate_pages_yaml_file
      YamlWriter.new(
        type: get_categorizable_title(category_title),
        category: category_title,
        template_name: template_title,
        file_name: 'pages'
      ).write!
    end

    def get_category(category_title)
      Category.find_by(title: category_title.humanize)
    end

    def get_categorizable_title(category_title)
      # rails underscore method does not work
      # Ex: "hello world".underscore = "hello world"
      underscorize(get_category(category_title).categorizable.title)
    end
end
