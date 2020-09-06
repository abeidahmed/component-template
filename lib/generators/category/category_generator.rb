class CategoryGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  argument :folder_name, type: :string

  def generate_category
    generate_category_folder
  end

  private
    def generate_category_folder
      directory = "app/templates/#{folder_name.underscore}"
      if File.exists?(directory)
        puts "#{folder_name} already exists in app/templates"
      else
        Dir.mkdir(directory)
        puts "Created new folder #{folder_name}"
      end
    end
end