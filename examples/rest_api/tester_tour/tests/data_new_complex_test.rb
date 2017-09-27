require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'
require_relative '../../../rest_api/data/user'

class DataNewComplexTest < BaseClassForTest

  def test_data_new_complex
    prelude do |_, log|
      log.section('Create and log an instance of a complex data object') do
        user = User.new(
            :id => nil,
            :name => 'Leanne Graham',
            :username => 'Bret',
            :email => 'Sincere@april.biz',
            :address => {
                :street => 'Kulas Light',
                :suite => 'Apt. 556',
                :city => 'Gwenborough',
                :zipcode => '92998-3874',
                :geo => {
                    :lat => '-37.3159',
                    :lng => '81.1496',
                }
            },
            :phone => '1-770-736-8031 x56442',
            :website => 'hildegard.org',
            :company => {
                :name => 'Romaguera-Crona',
                :catchPhrase => 'Multi-layered client-server neural-net',
                :bs => 'harness real-time e-markets',
            }
        )
        user.log(log)
      end
    end
  end

end
