class UiResourcesController < ApplicationController
  layout 'slate'

  def index
    @components = YAML::load_file(file_path 'components')
    @pages = YAML::load_file(file_path 'pages')
  end

  def show
    type, template_name = params[:type], params[:id]
    @template = if type === 'components'
      Component.find_by(title: template_name.underscore.humanize)
    elsif type === 'pages'
      Page.find_by(title: template_name.underscore.humanize)
    end
  end

  private
    def file_path(file_name)
      Rails.root.join("db", "#{file_name}.yml")
    end
end
