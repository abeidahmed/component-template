class CategoryGenerator < Rails::Generators::Base
  include ApplicationHelper

  source_root File.expand_path('templates', __dir__)

  argument :parent_name, type: :string
  argument :title, type: :string

  def generate_category
    create_category
  end

  private
    def create_category
      if parent_component_collection?
        parent = ComponentCollection.find_by(title: parent_name.humanize)
        create_category_and_folder_in(parent, 'components')
        generate_components_yaml_file
      elsif parent_page_collection?
        parent = PageCollection.find_by(title: parent_name.humanize)
        create_category_and_folder_in(parent, 'pages')
        generate_pages_yaml_file
      else
        return puts 'Please type in the correct PARENT NAME'
      end
    end

    def create_category_and_folder_in(parent, folder_name)
      if Category.exists?(title: title.humanize)
        return puts 'Category already exists!'
      else
        Category.create!(title: title.humanize, categorizable: parent)
        if folder_name == 'components'
          generate_category_in_components_folder
        else
          generate_category_in_pages_folder
        end
      end
    end

    def parent_component_collection?
      ComponentCollection.exists?(title: parent_name.humanize)
    end

    def parent_page_collection?
      PageCollection.exists?(title: parent_name.humanize)
    end

    def generate_category_in_components_folder
      directory = Rails.root.join('app', 'components', underscorize(title))
      Dir.mkdir(directory)
    end

    def generate_category_in_pages_folder
      directory = Rails.root.join('app', 'pages', underscorize(title))
      Dir.mkdir(directory)
    end

    def generate_components_yaml_file
      YamlWriter.new(
        type: parent_name,
        category: title,
        template_name: nil,
        file_name: 'components'
      ).write!
    end

    def generate_pages_yaml_file
      YamlWriter.new(
        type: parent_name,
        category: title,
        template_name: nil,
        file_name: 'pages'
      ).write!
    end
end
