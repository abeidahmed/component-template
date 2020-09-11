class TemplateGenerator < Rails::Generators::NamedBase
  include ApplicationHelper

  source_root File.expand_path('templates', __dir__)
  argument :file_title, type: :string

  # YAML_FILE_NAME = 'template_structure'

  def generate_category_title
    generate_template_boilerplate
    # write_to_yaml
  end

  private
    def generate_template_boilerplate
      copy_file "template_boilerplate.html", "app/templates/#{underscorize(name)}/#{file_title}.html"
    end

    # def write_to_yaml
    #   YamlWriter.new(
    #     type: 'components',
    #     category: name,
    #     template_name: file_title,
    #     file_name: YAML_FILE_NAME
    #   ).write!
    # end
end
