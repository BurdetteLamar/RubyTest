require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class EqualityTest < BaseClassForTest

  def test_equality

    prelude do |client, log|

      labels = Label.get_all(client)
      label_0 = labels[0]
      label_1 = labels[1]

      log.section('Determine whether two labels are equal') do
        equal = Label.equal?(label_0, label_1)
        comment = format('Equal?  %s', equal)
        log.comment(comment)
      end

      log.section('Verify that two labels are equal') do
        Label.verdict_equal?(log, :equal, label_0, label_1)
      end

      p log.counts

    end

  end

end