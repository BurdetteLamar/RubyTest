require_relative 'base_class_for_test'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|
      puts 'Boo!'
    end

  end

end