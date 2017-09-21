namespace :build do

  require 'rdoc'

  desc 'Build RDoc'
  RDoc::Task.new :rdoc do |rdoc|
    # For some reason, RubyMine thinks it cannot 'resolve' the quoted string, so this pragma.
    # noinspection RubyResolve
    rdoc.rdoc_files.include('*.rb')
    rdoc.title = 'RubyTest'
  end

  desc 'Build markdown table of contents'
  task :markdown_toc do
    path = File.join(
        File.dirname(__FILE__),
        '..',
        'lib',
        'helpers',
        'markdown_helper.rb',
    )
    command = "ruby -r #{path} -e MarkdownHelper.build_toc"
    system(command)
  end

  desc 'Build markdown for Rakefile'
  task :markdown_for_rakefile do
    Dir.chdir(File.join(File.dirname(__FILE__), '..')) do |_|
      output = `rake -D`
      output.gsub!("\n    ", "\n\n    ")
      File.open('Rakefile.md', 'w') do |file|
        file.puts <<EOT
# Rakefile

## Descriptions

EOT
        file.puts(output)
        file.puts <<EOT
## Source

- [Rakefile](Rakefile)
EOT
      end
    end

  end

  desc 'Build markdown for Gemfile'
  task :markdown_for_gemfile do
    output_lines = []
    Dir.chdir(File.join(File.dirname(__FILE__), '..')) do
      output = `grep "^gem\s" Gemfile`
      output.split("\n").each do |line|
        gem_name = line.split("'")[1]
        url = format('https://rubygems.org/gems/%s', gem_name)
        output_line = format('- [%s](%s)', gem_name, url)
        output_lines.push(output_line)
      end
      output_lines.push('')
      output = output_lines.join("\n")
      File.open('Gemfile.md', 'w') do |file|
        file.puts <<EOT
# Gemfile

## Gems

EOT
        file.puts(output)
        file.puts <<EOT
## Source

- [Gemfile](Gemfile)
EOT
      end
    end
  end


  desc 'Build everything'
  # After other markdown built, do TOC.
  # After everything else built, do RDoc.
  task :all => %w/
    build:markdown_for_gemfile
    build:markdown_for_rakefile
    build:markdown_toc
    build:rerdoc
   /

end
