# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

file_path = Rails.root.join('db', 'components.yml')
doc = YAML::load_file(file_path)

doc.each do |title, contents|
  component_collection = if ComponentCollection.exists? title: title.humanize
    ComponentCollection.find_by title: title.humanize
  else
    ComponentCollection.create! title: title.humanize
  end
  contents.each do |category, templates|
    cat = if Category.exists? title: category.humanize
      Category.find_by title: category.humanize
    else
      Category.create! title: category.humanize, categorizable: component_collection
    end
    templates.each do |template|
      unless Component.exists? title: template.humanize
        Component.create! title: template.humanize, category_id: cat.id
      end
    end
  end
end