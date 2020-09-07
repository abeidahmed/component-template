class TemplateGenerator < Rails::Generators::NamedBase
  include ApplicationHelper

  source_root File.expand_path('templates', __dir__)
  argument :file_title, type: :string

  def generate_category_title
    generate_template_boilerplate
  end

  private
    def generate_template_boilerplate
      copy_file "template_boilerplate.liquid", "app/templates/#{underscorize(name)}/#{file_title}.liquid"
    end
end
