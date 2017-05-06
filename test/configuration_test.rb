require 'yaml'

require_relative 'common_requires'

require_relative '../lib/configuration'

# Class to test class +Configuration+.
class ConfigurationTest < MiniTest::Test

  def test_all

    dir_path = Dir.mktmpdir

    main_file_name = 'main.yaml'
    main_file_path = File.join(
        dir_path,
        main_file_name,
    )
    include_file_name = 'include.yaml'
    include_file_path = File.join(
        dir_path,
        include_file_name,
    )
    more_file_name = 'more.yaml'
    more_file_path = File.join(
        dir_path,
        more_file_name,
    )

    # Yaml with included files.
    main_yaml = <<EOT
foo: whatever
bar:
 -
   fruit: apple
   name: steve
   sport: baseball
 - more
 -
   python: rocks
   perl: papers
   ruby: scissors
__include__:
- ./#{include_file_name}
- ./#{more_file_name}
EOT

    # Yaml to be included.
    included_yaml = <<EOT
languages: [ Ruby,
             Perl,
             Python ]
websites: { YAML: yaml.org,
            Ruby: ruby-lang.org,
            Python: python.org,
            Perl: use.perl.org }
EOT

    # More yaml to be included.
    more_yaml = <<EOT
zero: 0
simple: 12
one-thousand: 1,000
negative one-thousand: -1,000
EOT

    File.open(main_file_path, 'w') do |file|
      file.write(main_yaml)
    end
    File.open(include_file_path, 'w') do |file|
      file.write(included_yaml)
    end
    File.open(more_file_path, 'w') do |file|
      file.write(more_yaml)
    end

    expected_data = {
        :foo => 'whatever',
        :bar => [
            {
                :fruit => 'apple',
                :name => 'steve',
                :sport => 'baseball',
            },
            'more',
            {
                :python => 'rocks',
                :perl => 'papers',
                :ruby => 'scissors'
            }
        ],
        :languages => %w/
            Ruby
            Perl
            Python
        /,
        :websites => {
            :YAML => 'yaml.org',
            :Ruby => 'ruby-lang.org',
            :Python => 'python.org',
            :Perl => 'use.perl.org',
        },
        :zero => 0,
        :simple => 12,
        :'one-thousand' => 1000,
        :'negative one-thousand' => -1000
    }

    config = Configuration.new(main_file_path)
    actual_data = config.get

    # Verify the full configuration.
    self.assert_equal(expected_data, actual_data, 'Full configuration')

    # Verify levelled gets.
    expected_websites = expected_data[:websites]
    actual_websites = config.get('websites')
    self.assert_equal(expected_websites, actual_websites, 'Node websites')
    expected_ruby = expected_websites[:Ruby]
    actual_ruby = config.get('Ruby', actual_websites)
    self.assert_equal(expected_ruby, actual_ruby, 'Node Ruby')

    # Verify get with multi-node path.
    expected_ruby = expected_data[:websites][:Ruby]
    actual_ruby = config.get('websites/Ruby')
    self.assert_equal(expected_ruby, actual_ruby, 'Node Ruby')

    FileUtils.rm_r(dir_path)

  end

end


