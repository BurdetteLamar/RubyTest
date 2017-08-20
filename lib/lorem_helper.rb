require 'lorem-ipsum'

require_relative 'base_classes/base_class'

class LoremHelper < BaseClass

  include Contracts

  class Lorem

    include Contracts
    include LoremIpsum

    def initialize
      # Locate the file (in the gem's directory).
      spec = Gem::Specification.find_by_name('lorem-ipsum')
      gem_root = spec.gem_dir
      lorem_file_path = File.join(gem_root, 'data', 'lorem.txt')
      @lorem = Generator.new
      @lorem.analyze(lorem_file_path)
    end

    Contract Num => String
    # Return lorem-ipsum string with given word count.
    def sentence(word_count)
      @lorem.next_sentence(word_count).strip
    end

    def words(word_count)
      sentence(word_count).gsub(/\./, '').downcase
    end

  end

  Contract None => self::Lorem
  # Return Lorem generator.
  def self.generator
    self::Lorem.new
  end

end


