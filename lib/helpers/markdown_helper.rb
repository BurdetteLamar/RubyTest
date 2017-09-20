require_relative '../../lib/base_classes/base_class'

class MarkdownHelper < BaseClass

  FILE_SOURCE_TAG = '[file_source]'

  def self.build_markdown_file(template_file_path, markdown_file_path, highlight = true)
    File.open(template_file_path, 'r') do |template_file|
      File.open(markdown_file_path, 'w') do |md_file|
        template_file.each_line do |line|
          case
            when line.start_with?(FILE_SOURCE_TAG)
              relative_path = line.sub(FILE_SOURCE_TAG, '').gsub(/[()]/, "").strip
              absolute_path = File.absolute_path(File.join(
                  File.dirname(template_file_path),
                  relative_path,
              ))
              label_line = format('<code>%s</code>', File.basename(absolute_path))
              md_file.puts(label_line)
              if highlight
                extname = File.extname(absolute_path)
                case extname
                  when '.xml'
                    md_file.puts('```xml')
                  when '.rb'
                    md_file.puts('```ruby')
                  else
                    raise NotImplementedError.new(extname)
                end
              end
              file_source = File.read(absolute_path)
              md_file.puts(file_source)
              md_file.puts('```') if highlight
            else
              md_file.puts(line)
          end
        end
      end
    end

  end
end