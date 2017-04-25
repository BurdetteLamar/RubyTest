namespace :examples do

  EXAMPLES_DIR = File.join(
      File.dirname(__FILE__),
      '..',
      'examples',
  )

  def run_examples(examples_file_path)
    path = File.absolute_path(File.join(
        EXAMPLES_DIR,
        examples_file_path,
    ))
    puts format('Running %s', path)
    command = format('ruby %s', path)
    exit unless system(command)
  end

  desc 'Run examples for class Log'
  task :log do
    run_examples('log/log_examples.rb')
  end

  desc 'Run examples for REST API'
  task :rest_api do
    %w/
        albums
        comments
        photos
        posts
        todos
        users
    /.each do |name|
      path = format('rest_api/tests/%s_test.rb', name)
      run_examples(path)
    end
  end

  desc 'Run all examples'
  task :all => %w/
    examples:log
    examples:rest_api
   /

end
