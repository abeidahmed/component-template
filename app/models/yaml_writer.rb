class YamlWriter
  # Structure of yaml file as ruby hash
  # ----------------------
  # doc = {
  #   type: {
  #     category: [
  #       'template-1',
  #       'template-2',
  #       'rest of the template...'
  #     ]
  #   }
  # }

  def initialize(**options)
    @type = options[:type]
    @category = options[:category]
    @template_name = options[:template_name]
    @file_name = options[:file_name]
  end

  attr_reader :type, :category, :template_name, :file_name

  def file_path
    Rails.root.join('db', "#{file_name}.yml")
  end

  def write!
    create_file_if_file_does_not_exist

    @doc = YAML::load_file(file_path)
    if doc_is_initialized_and_has_type?
      if doc_type_has_category?
        add_template_to_category
      else
        initialize_category
        add_template_to_category
      end
    elsif doc_is_initialized_and_does_not_has_type?
      initialize_doc_type
      initialize_category
      add_template_to_category
    else
      initialize_doc
      initialize_doc_type
      initialize_category
      add_template_to_category
    end
    File.open(file_path, 'w') { |f| f.write @doc.to_yaml }
  end

  private
    def create_file_if_file_does_not_exist
      File.new(file_path, 'w') unless File.exists?(file_path)
    end

    def doc_is_initialized_and_has_type?
      @doc && doc_has_type?
    end

    def doc_is_initialized_and_does_not_has_type?
      @doc && !doc_has_type?
    end

    def doc_has_type?
      @doc.has_key?(type)
    end

    def doc_type_has_category?
      @doc[type].has_key?(category)
    end

    def initialize_doc
      @doc = {}
    end

    def initialize_doc_type
      @doc[type] = {}
    end

    def initialize_category
      @doc[type][category] = []
    end

    def add_template_to_category
      @doc[type][category] << template_name unless template_name.nil?
    end
end