require 'find'

require_relative '../lib/base_class'

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

    # Get the p.md file paths.
    file_paths = []
    Find.find('.') do |path|
      next unless path.end_with?('.md')
      file_paths.push(path)
    end

    # Verify that we have the top file path.
    toc_file_path = './Contents.md'
    unless file_paths.delete(toc_file_path)
      puts 'Did not find top file: ' + toc_file_path
      fail
    end

    titles_by_file_path = {}
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

    toc_tree = {}
    titles_by_file_path.each_pair do |path, title|
      names = path.split('/')[1..-1]
      node_names = names[1..-1]
      tree = toc_tree
      names.each_with_index do |node_name, i|
        tree.store(node_name, {}) unless tree.include?(node_name)
        tree = tree.fetch(node_name)
        if i == node_names.size - 1
          tree.store(path, title)
        end
      end
    end
    DebugHelper.puts_hash(toc_tree)
    lines = [
        '# Contents',
        '',
    ]
    self.toc_lines(lines, toc_tree)

    # End with a newline.
    lines.push('')

    markdown = lines.join("\n")

    File.open(toc_file_path, 'w') do |file|
      file.write(markdown)
    end

  end

  private

  def self.toc_lines(lines, tree, level = 0)
    tree.each_pair do |path, value|
      if value.respond_to?(:each_pair)
        self.toc_lines(lines, value, level + 1)
      else
        indentation = ' ' * (level - 1) * 4
        value = value.split('/').last
        if value.end_with?('.md')
          lines.push(format('%s- [%s](%s)', indentation, value, path))
        else
          lines.push(format('%s- %s', indentation, value))
        end
      end
    end
  end

end
