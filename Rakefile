namespace :test do

  TEST_DIR = File.join(
      File.dirname(__FILE__),
      'test',
  )

  def autorun(test_file_path)
    path = File.absolute_path(File.join(
        TEST_DIR,
        test_file_path,
    ))
    command = "ruby #{path}"
    exit unless system(command)
  end

  desc 'Test class StringHelper'
  task :string_helper do
    autorun(File.join(
                    'helpers',
                    'string_helper_test.rb',
    )
    )
  end

  desc 'Test class ValuesHelper'
  task :values_helper do
    autorun(File.join(
        'helpers',
        'values_helper_test.rb',
    )
    )
  end

  desc 'Test all classes'
  task :all => %w/
     test:string_helper
     test:values_helper
   /

end

namespace :build do

  require 'rdoc'

  desc 'Build RDoc'
  RDoc::Task.new :rdoc do |rdoc|
    # For some reason, RubyMine thinks it cannot 'resolve' the quoted string, so this pragma.
    # noinspection RubyResolve
    rdoc.rdoc_files.include('*.rb')
    rdoc.title = 'RubyTest'
  end

  TOOLS_DIR = File.join(
      File.dirname(__FILE__),
      'tools',
  )

  desc 'Build markdown table of contents'
  task :markdown_toc do
    path = File.join(
        TOOLS_DIR,
        'create_markdown_toc.rb',
    )
    command = "ruby -r #{path} -e MarkdownToc.create"
    system(command)
  end

  desc 'Build markdown for Rakefile'
  task :markdown_for_rakefile do
    Dir.chdir(File.dirname(__FILE__))
    output = `rake -D`
    output.gsub!("\n    ", "\n\n    ")
    File.open('Rakefile.md', 'w') do |file|
      file.puts <<EOT
# Rakefile

## Descriptions

EOT
      file.puts(output)
      file.puts <<EOT
## Code

- [Rakefile](Rakefile)
EOT
    end
  end

  desc 'Build markdown for Gemfile'
  task :markdown_for_gemfile do
    output_lines = []
    Dir.chdir(File.dirname(__FILE__))
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
## Code

- [Gemfile](Gemfile)
EOT
    end
  end

  desc 'Build everything'
  task :all => %w/
    build:markdown_for_gemfile
    build:markdown_for_rakefile
    build:markdown_toc
    build:rerdoc
   /

end
