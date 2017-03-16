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
    p command
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

  desc 'Build everything'
  task :all => %w/
     build:markdown_toc
     build:rerdoc
   /

end
