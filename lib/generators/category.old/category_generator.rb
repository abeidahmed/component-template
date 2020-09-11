# class CategoryGenerator < Rails::Generators::Base
  # include ApplicationHelper

  # source_root File.expand_path('templates', __dir__)
  # argument :folder_name, type: :string

  # def generate_category
  #   if create_category
  #     generate_category_folder
  #   else
  #     puts "Category #{folder_name} already exists"
  #   end
  # end

  # private
  #   def generate_category_folder
  #     directory = "app/templates/#{underscorize(folder_name)}"
  #     if File.exists?(directory)
  #       puts "#{folder_name} already exists in app/templates"
  #     else
  #       Dir.mkdir(directory)
  #       puts "Created new folder #{folder_name}"
  #     end
  #   end

  #   def create_category
  #     title = folder_name.humanize
  #     Category.create!(title: title) unless Category.exists?(title: title)
  #   end
# end