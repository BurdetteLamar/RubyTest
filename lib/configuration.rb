require 'yaml'

require_relative 'base_classes/base_class'

class Configuration < BaseClass

  # When this key is seen in the yaml,
  # it must be followed by a list of relative file paths.
  INCLUDE_KEY = '__include__'

  # Get data from yaml file.
  Contract Maybe[String] => self
  def initialize(file_path)

    @dir_path = File.dirname(File.expand_path(file_path))

    File.open(file_path, 'r') do |file|
      # RubyMine inspection thinks this is an implicit required file.
      # noinspection RubyResolve
      content = YAML.load(file) || {}
      @values = content
      revise!(@values)
    end
    self
  end

  # Get values from the yaml data.
  # The path is slash-separated node-names in the yaml; if omitted gets all.
  # Example path:  'test/log/root_dir_path'.
  # If values is given, it must be something that was returned elsewhere by this very method.
  # Thus, you can do this:
  #   baz = config.get('foo/bar')
  #   bat = config.get('bat', baz)
  Contract String, Or[Hash, Array, String, Bool, Num] => Or[Hash, Array, String, Bool, Num]
  def get(path = '', values = @values)
    # Path comes in as 'foo/bar/baz'
    # whose tokens refer to nested sections in the yaml.
    node_names = path.split('/')
    node = values
    until node_names.empty?
      node = case
               when node.respond_to?(:each_pair)
                 node_name = node_names.shift
                 # The keys are symbols.
                 key = node_name.to_sym
                 unless node.include?(key)
                   message = 'Cannot find node %s for path %s' % [node_name, path]
                   raise ArgumentError.new(message)
                 end
                 node[key]
               when node.respond_to?(:each)
                 index = node_names.shift.to_i
                 value_at_index = node[index]
                 unless value_at_index
                   message = 'Cannot find item %d for path %s' % [index, path]
                   raise ArgumentError.new(message)
                 end
                 value_at_index
               else
                 raise NotImplementedError.new(node.class)
             end
    end
    node
  end

  private

  # Revise the data gathered from yaml by:
  #   -- Performing file inclusion.
  #   -- Changing all hash keys to symbols.
  Contract Any => nil
  def revise!(values)
    case
    when values.respond_to?(:each_pair)
      values.keys.each do |key|
        value = values.fetch(key)
        if key == INCLUDE_KEY
          include_file!(key, value, values)
        else
          revise_key!(key, value, values)
        end
      end
    when values.respond_to?(:each)
      values.each do |value|
        revise!(value)
      end
    else
      # Nothing to do.
    end
    nil
  end

  # Include yaml from specified files.
  Contract String, Or[Hash, Array, String, Bool, Num], Or[Hash, Array, String, Bool, Num] => nil
  def include_file!(inclusion_key, file_paths, values)
    # File paths must be a list.
    unless file_paths.kind_of?(Array)
      message = "#{inclusion_key} must contain a yaml list"
      raise RuntimeError.new(message)
    end
    # Process the list of relative file paths.
    file_paths.each do |relative_file_path|
      # Get the absolute file path.
      file_path = File.expand_path(
          File.join(
              @dir_path,
              relative_file_path
          )
      )

      values.delete(inclusion_key)
      new_values = Configuration.new(file_path).get('')
      new_values.each do |key, value|
        values.store(key, value)
      end

    end
    nil
  end

  # Revise a string key to a symbol key.
  Contract Or[String, Symbol], Or[Hash, Array, String, Bool, Num], Or[Hash, Array, String, Bool, Num] => nil
  def revise_key!(old_key, value, values)
    new_key = old_key.to_sym
    values.delete(old_key)
    values.store(new_key, value)
    # Revise nested data.
    revise!(value)
    nil
  end

end
