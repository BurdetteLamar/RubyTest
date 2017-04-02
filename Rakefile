RAKEFILES_DIR_PATH = File.join(
    File.dirname(__FILE__),
    'rakefiles'
)

load "#{RAKEFILES_DIR_PATH}/examples.rake"
load "#{RAKEFILES_DIR_PATH}/build.rake"
load "#{RAKEFILES_DIR_PATH}/test.rake"

task :default do
  message = 'No default for this rakefile;  Type "rake -D" for task descriptions.'
  raise ArgumentError.new(message)
end



