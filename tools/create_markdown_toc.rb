require 'find'

require_relative '../lib/base_classes/base_class'

# Class to make a table of contents for markdown files.
class MarkdownToc < BaseClass

  def self.create

    # Verify that we're in the right directory.
    actual_dirname = File.basename(Dir.pwd)
    expected_dirname = 'RubyTest'
    if actual_dirname != expected_dirname
      puts 'Actual dirpath: ' + Dir.pwd
      puts 'Actual dirname: ' + actual_dirname
      puts 'Expected dirname: ' + expected_dirname
      fail
    end

    toc_file_path = './Contents.md'

    # Get the .md file paths.
    file_paths = []
    Find.find('.') do |path|
      next unless path.end_with?('.md')
      file_paths.push(path)
    end

    # Don't put the TOC in the TOC.
    file_paths.delete(toc_file_path)

    # The title is from the .md file text, not the file name.
    titles_by_file_path = {}
    # Use file_path as key;  title may be repeated.
    file_paths.sort.each do |path|
      File.open(path) do |file|
        title_line = file.readline
        unless title_line.start_with?('# ')
          puts 'First line is not a title: ' + title_line
          fail
        end
        title = title_line[2..-1].chomp
        titles_by_file_path.store(path, title)
      end
    end

    def self.store_p(hash, keys, value)
      # Don't disturb caller's keys.
      keys_clone = keys.clone
      # Save the last key for the value.
      last_key = keys_clone.pop
      # Walk using this temp hash.
      h = hash
      keys_clone.each do |key|
        # Create entry if necessary, and descend into it.
        h.store(key, {}) unless h.include?(key)
        h = h.fetch(key)
      end
      # Store the value with the last key.
      h.store(last_key, value)
      hash
    end

    tree = {}
    titles_by_file_path.each_pair do |file_path, title|
      # Split file_path into dir_names.
      keys = file_path.split('/')
      # Discard the file_name.
      keys.pop
      # Use the file_path as the key for the title:  file_path => title.
      keys.push(file_path)
      # Add to the tree hash.
      self.store_p(tree, keys, title)
    end

    lines = [
        '# Contents (Markdown Pages)',
        '',
    ]

    def self.do_level(lines, entry, level)
      entry.each_pair do |path, node|
        if node.respond_to?(:each_pair)
          if path != '.'
            entry = format('%s - %s', '  ' * level, path)
            lines.push(entry)
          end
          self.do_level(lines, node, level+1)
        else
          link = format('%s - [%s](%s)', '  ' * level, node, path)
          lines.push(link)
        end
      end
    end

    level = 0
    self.do_level(lines, tree, level)
    lines.push('')
    File.open(toc_file_path, 'w') do |file|
      file.write(lines.join("\n"))
    end

  end

end
