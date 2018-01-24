require 'find'

require_relative '../../lib/base_classes/base_class'

class MarkdownHelper < BaseClass

  FILE_SOURCE_TAG = '[file_source]'
  NAVIGATION_LINKS_TAG = '[navigation_links]'

  def self.build_file(template_file_path, markdown_file_path, options)
    default_options = {
        :highlight => true,
        :prev_bookmark_path => nil,
        :next_bookmark_path => nil,
        :prev_title => nil,
        :next_title => nil,
    }
    effective_options = default_options.merge(options)
    highlight = effective_options[:highlight]
    prev_bookmark_path = effective_options[:prev_bookmark_path]
    next_bookmark_path = effective_options[:next_bookmark_path]
    prev_title = effective_options[:prev_title]
    next_title = effective_options[:next_title]
    File.open(template_file_path, 'r') do |template_file|
      File.open(markdown_file_path, 'w') do |md_file|
        md_file.puts('<!--- GENERATED FILE, DO NOT EDIT --->')
        template_file.each_line do |line|
          case
            when line.start_with?(NAVIGATION_LINKS_TAG)
              unless prev_bookmark_path.empty?
                prev_link = format('**Prev Stop:** [%s](%s)', prev_title, prev_bookmark_path)
                md_file.puts(prev_link)
                md_file.puts('')
              end
              unless next_bookmark_path.empty?
                next_link = format('**Next Stop:** [%s](%s)', next_title, next_bookmark_path)
                md_file.puts(next_link)
                md_file.puts('')
              end
            when line.start_with?(FILE_SOURCE_TAG)
              relative_path = line.sub(FILE_SOURCE_TAG, '').gsub(/[()]/, '').strip
              include_file_path = File.join(
                  File.dirname(template_file_path),
                  relative_path,
              )
              label_line = format('<code>%s</code>', File.basename(include_file_path))
              md_file.puts(label_line)
              if highlight
                extname = File.extname(include_file_path)
                case extname
                  when '.xml'
                    md_file.puts('```xml')
                  when '.rb'
                    md_file.puts('```ruby')
                  else
                    raise NotImplementedError.new(extname)
                end
              end
              file_source = File.read(include_file_path)
              md_file.puts(file_source)
              md_file.puts('```') if highlight
            else
              md_file.puts(line)
          end
        end
      end
    end

  end

  def self.build_toc

    # Verify that we're in the right directory.
    # TODO:  This needs to be better!
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
      next if path.match(%r:/tester_tour/md_files/:)
      file_paths.push(path)
    end

    # Don't put the TOC in the TOC.
    file_paths.delete(toc_file_path)

    # The title is from the .md file text, not the file name.
    titles_by_file_path = {}
    @anchors_by_file_path = {}
    # Use file_path as key;  title may be repeated.
    file_paths.sort.each do |path|
      File.open(path) do |file|
        title_line = file.readline
        unless title_line.start_with?('# ')
          puts 'First line is not a title: ' + title_line
          fail path
        end
        title = title_line[2..-1].chomp
        anchor = title.gsub(/\s+/, '-').downcase
        @anchors_by_file_path.store(path, anchor)
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
      if level == 1
        # Sensibly order the uppermost .md files.
        inverted_entry = entry.invert
        %w/
            RubyTest
            Watchwords
            Future
            Rakefile
            Gemfile
        /.each do |node|
          path = inverted_entry.fetch(node)
          entry.delete(path)
          anchor = @anchors_by_file_path[path]
          link = format('%s - [%s](%s)', '  ' * level, node, format('%s#%s', path, anchor))
          lines.push(link)
        end
      end
      entry.each_pair do |path, node|
        if node.respond_to?(:each_pair)
          if path != '.'
            entry = format('%s - %s/', '  ' * level, path)
            lines.push(entry)
          end
          self.do_level(lines, node, level+1)
        else
          anchor = @anchors_by_file_path[path]
          p anchor
          link = format('%s - [%s](%s)', '  ' * level, node, format('%s#%s', path, anchor))
          lines.push(link)
          p link
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